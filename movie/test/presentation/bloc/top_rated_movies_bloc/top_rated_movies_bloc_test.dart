import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/top_rated_movies_bloc/top_rated_movies_bloc.dart';

import 'top_rated_movies_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMoviesBloc topRatedMoviesBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesBloc = TopRatedMoviesBloc(mockGetTopRatedMovies);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  group('TopRated Movies', () {
    test('Initial state should be empty', () {
      expect(topRatedMoviesBloc.state, TopRatedMoviesEmpty());
    });

    blocTest<TopRatedMoviesBloc, TopRatedMoviesState> (
      'Should emit [TopRatedMoviesLoading, TopRatedMoviesLoaded] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(TopRatedMoviesEvent()),
      expect: () => [
        TopRatedMoviesLoading(),
        TopRatedMoviesLoaded(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<TopRatedMoviesBloc, TopRatedMoviesState> (
      'Should emit [TopRatedMoviesLoading, TopRatedMoviesLoaded[], TopRatedMoviesEmpty] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(<Movie>[]));
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(TopRatedMoviesEvent()),
      expect: () => [
        TopRatedMoviesLoading(),
        TopRatedMoviesLoaded(const <Movie>[]),
        TopRatedMoviesEmpty(),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<TopRatedMoviesBloc, TopRatedMoviesState> (
      'Should emit [TopRatedMoviesLoading, TopRatedMoviesError] when get Failure',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(TopRatedMoviesEvent()),
      expect: () => [
        TopRatedMoviesLoading(),
        TopRatedMoviesError('Failed'),
      ],
      verify: (_) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });
}
