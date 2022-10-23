import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/presentation/bloc/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movies_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMoviesBloc popularMoviesBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMoviesBloc = PopularMoviesBloc(mockGetPopularMovies);
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

  group('Popular Movies', () {
    test('Initial state should be empty', () {
      expect(popularMoviesBloc.state, PopularMoviesEmpty());
    });

    blocTest<PopularMoviesBloc, PopularMoviesState> (
      'Should emit [PopularMoviesLoading, PopularMoviesLoaded] when data is gotten successfully',
      build: () {
        when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
        return popularMoviesBloc;
      },
      act: (bloc) => bloc.add(PopularMoviesEvent()),
      expect: () => [
        PopularMoviesLoading(),
        PopularMoviesLoaded(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<PopularMoviesBloc, PopularMoviesState> (
      'Should emit [PopularMoviesLoading, PopularMoviesLoaded[], PopularMoviesEmpty] when data is gotten successfully',
      build: () {
        when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(<Movie>[]));
        return popularMoviesBloc;
      },
      act: (bloc) => bloc.add(PopularMoviesEvent()),
      expect: () => [
        PopularMoviesLoading(),
        PopularMoviesLoaded(const <Movie>[]),
        PopularMoviesEmpty(),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<PopularMoviesBloc, PopularMoviesState> (
      'Should emit [PopularMoviesLoading, PopularMoviesError] when get Failure',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return popularMoviesBloc;
      },
      act: (bloc) => bloc.add(PopularMoviesEvent()),
      expect: () => [
        PopularMoviesLoading(),
        PopularMoviesError('Failed'),
      ],
      verify: (_) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });
}
