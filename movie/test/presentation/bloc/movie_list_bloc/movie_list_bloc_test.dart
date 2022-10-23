import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:core/common/failure.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/movie_list_bloc/movie_list_bloc.dart';

import 'movie_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
void main() {
  late NowPlayingMovieListBloc nowPlayingMovieListBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late PopularMovieListBloc popularMovieListBloc;
  late MockGetPopularMovies mockGetPopularMovies;
  late TopRatedMovieListBloc topRatedMovieListBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMovieListBloc = NowPlayingMovieListBloc(mockGetNowPlayingMovies);
    mockGetPopularMovies = MockGetPopularMovies();
    popularMovieListBloc = PopularMovieListBloc(mockGetPopularMovies);
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMovieListBloc = TopRatedMovieListBloc(mockGetTopRatedMovies);
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

  group('now playing movie list', () {
    test('Initial state should be empty', () {
      expect(nowPlayingMovieListBloc.state, MovieListEmpty());
    });

    blocTest<NowPlayingMovieListBloc, MovieListState> (
      'Should emit [MovieListLoading, MovieListLoaded] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
        return nowPlayingMovieListBloc;
      },
      act: (bloc) => bloc.add(MovieListEvent()),
      expect: () => [
        MovieListLoading(),
        MovieListLoaded(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<NowPlayingMovieListBloc, MovieListState> (
      'Should emit [MovieListLoading, MovieListError] when get Failure',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return nowPlayingMovieListBloc;
      },
      act: (bloc) => bloc.add(MovieListEvent()),
      expect: () => [
        MovieListLoading(),
        MovieListError('Failed'),
      ],
      verify: (_) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });

  group('popular movie list', () {
    test('Initial state should be empty', () {
      expect(popularMovieListBloc.state, MovieListEmpty());
    });

    blocTest<PopularMovieListBloc, MovieListState> (
      'Should emit [MovieListLoading, MovieListLoaded] when data is gotten successfully',
      build: () {
        when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
        return popularMovieListBloc;
      },
      act: (bloc) => bloc.add(MovieListEvent()),
      expect: () => [
        MovieListLoading(),
        MovieListLoaded(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<PopularMovieListBloc, MovieListState> (
      'Should emit [MovieListLoading, MovieListError] when get Failure',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return popularMovieListBloc;
      },
      act: (bloc) => bloc.add(MovieListEvent()),
      expect: () => [
        MovieListLoading(),
        MovieListError('Failed'),
      ],
      verify: (_) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });

  group('top rated movie list', () {
    test('Initial state should be empty', () {
      expect(topRatedMovieListBloc.state, MovieListEmpty());
    });

    blocTest<TopRatedMovieListBloc, MovieListState> (
      'Should emit [MovieListLoading, MovieListLoaded] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
        return topRatedMovieListBloc;
      },
      act: (bloc) => bloc.add(MovieListEvent()),
      expect: () => [
        MovieListLoading(),
        MovieListLoaded(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<TopRatedMovieListBloc, MovieListState> (
      'Should emit [MovieListLoading, MovieListError] when get Failure',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return topRatedMovieListBloc;
      },
      act: (bloc) => bloc.add(MovieListEvent()),
      expect: () => [
        MovieListLoading(),
        MovieListError('Failed'),
      ],
      verify: (_) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });
}
