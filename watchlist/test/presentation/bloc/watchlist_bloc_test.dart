import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:watchlist/domain/usecases/get_watchlist_movies.dart';
import 'package:watchlist/domain/usecases/get_watchlist_tv_shows.dart';
import 'package:watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies, GetWatchlistTvShows])
void main() {
  late WatchlistMoviesBloc watchlistMoviesBloc;
  late WatchlistTvShowsBloc watchlistTvShowsBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchlistTvShows mockGetWatchlistTvShows;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchlistTvShows = MockGetWatchlistTvShows();
    watchlistMoviesBloc = WatchlistMoviesBloc(mockGetWatchlistMovies);
    watchlistTvShowsBloc = WatchlistTvShowsBloc(mockGetWatchlistTvShows);
  });

  final tMovies = <Movie>[testMovie];

  group('Watchlist Movies', () {

    test('Initial state should be empty', () {
      expect(watchlistMoviesBloc.state, WatchlistEmpty(''));
    });

    blocTest<WatchlistMoviesBloc, WatchlistState> (
      'Should emit [WatchlistLoading, WatchlistHasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(tMovies));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(WatchlistEvent()),
      expect: () => [
        WatchlistLoading(),
        WatchlistHasData(tMovies),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );

    blocTest<WatchlistMoviesBloc, WatchlistState> (
      'Should emit [WatchlistLoading, WatchlistHasData[], WatchlistEmpty] when data is empty',
      build: () {
        when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(<Movie>[]));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(WatchlistEvent()),
      expect: () => [
        WatchlistLoading(),
        WatchlistHasData(const <Movie>[]),
        WatchlistEmpty('You haven\'t added a watch list'),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );

    blocTest<WatchlistMoviesBloc, WatchlistState> (
      'Should emit [WatchlistLoading, WatchlistError] when data is unsuccessful',
      build: () {
        when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(WatchlistEvent()),
      expect: () => [
        WatchlistLoading(),
        WatchlistError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );
  });

  final tTvShows = <TvShow>[testTvShow];

  group('Watchlist Tv Shows', () {

    test('Initial state should be empty', () {
        expect(watchlistTvShowsBloc.state, WatchlistEmpty(''));
    });

    blocTest<WatchlistTvShowsBloc, WatchlistState> (
      'Should emit [WatchlistLoading, WatchlistHasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistTvShows.execute())
          .thenAnswer((_) async => Right(tTvShows));
        return watchlistTvShowsBloc;
      },
      act: (bloc) => bloc.add(WatchlistEvent()),
      expect: () => [
        WatchlistLoading(),
        WatchlistHasData(tTvShows),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvShows.execute());
      },
    );

    blocTest<WatchlistTvShowsBloc, WatchlistState> (
      'Should emit [WatchlistLoading, WatchlistHasData[], WatchlistEmpty] when data is empty',
      build: () {
        when(mockGetWatchlistTvShows.execute())
          .thenAnswer((_) async => Right(<TvShow>[]));
        return watchlistTvShowsBloc;
      },
      act: (bloc) => bloc.add(WatchlistEvent()),
      expect: () => [
        WatchlistLoading(),
        WatchlistHasData(const <TvShow>[]),
        WatchlistEmpty('You haven\'t added a watch list'),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvShows.execute());
      },
    );

    blocTest<WatchlistTvShowsBloc, WatchlistState> (
      'Should emit [WatchlistLoading, WatchlistError] when data is unsuccessful',
      build: () {
        when(mockGetWatchlistTvShows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistTvShowsBloc;
      },
      act: (bloc) => bloc.add(WatchlistEvent()),
      expect: () => [
        WatchlistLoading(),
        WatchlistError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvShows.execute());
      },
    );
  });
}
