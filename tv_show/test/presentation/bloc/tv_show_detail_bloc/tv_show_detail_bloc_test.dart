import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/season.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/entities/tv_show_detail.dart';
import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/domain/usecases/get_tv_show_detail.dart';
import 'package:tv_show/domain/usecases/get_tv_show_recommendations.dart';
import 'package:tv_show/presentation/bloc/tv_show_detail_bloc/tv_show_detail_bloc.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status_tv_show.dart';
import 'package:watchlist/domain/usecases/remove_watchlist_tv_show.dart';
import 'package:watchlist/domain/usecases/save_watchlist_tv_show.dart';

import 'tv_show_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvShowDetail,
  GetTvShowRecommendations,
  GetWatchListStatusTvShow,
  SaveWatchlistTvShow,
  RemoveWatchlistTvShow,
])
void main() {
  late TvShowDetailBloc tvShowDetailBloc;
  late MockGetTvShowDetail mockGetTvShowDetail;
  late MockGetTvShowRecommendations mockGetTvShowRecommendations;
  late MockGetWatchListStatusTvShow mockGetWatchlistStatus;
  late MockSaveWatchlistTvShow mockSaveWatchlist;
  late MockRemoveWatchlistTvShow mockRemoveWatchlist;

  setUp(() {
    mockGetTvShowDetail = MockGetTvShowDetail();
    mockGetTvShowRecommendations = MockGetTvShowRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatusTvShow();
    mockSaveWatchlist = MockSaveWatchlistTvShow();
    mockRemoveWatchlist = MockRemoveWatchlistTvShow();
    tvShowDetailBloc = TvShowDetailBloc(
      getTvShowDetail: mockGetTvShowDetail,
      getTvShowRecommendations: mockGetTvShowRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const tId = 1;
  final TvShowDetailStateInit = TvShowDetailState.initial();
  final tTvShow = TvShow(
      backdropPath: "/xAKMj134XHQVNHLC6rWsccLMenG.jpg",
      firstAirDate: "2021-10-12",
      genreIds: const [10765, 35, 80],
      id: 90462,
      name: "Chucky",
      originalName: "Chucky",
      overview:
          "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the town’s hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chucky’s past threatens to expose the truth behind the killings, as well as the demon doll’s untold origins.",
      popularity: 6008.272,
      posterPath: "/iF8ai2QLNiHV4anwY1TuSGZXqfN.jpg",
      voteAverage: 8,
      voteCount: 987
  );
  final tTvShows = <TvShow>[tTvShow];

  final tTvShowDetail = TvShowDetail(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genres: const [Genre(id: 1, name: 'Comedy')],
    id: 1,
    name: 'name',
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    seasons: const [
      Season(
        airDate: 'airDate',
        episodeCount: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        posterPath: 'posterPath',
        seasonNumber: 1,
      )
    ],
    tagline: 'tagline',
    voteAverage: 1,
    voteCount: 1,
  );

  group('Get TvShow Detail', () {

    blocTest<TvShowDetailBloc, TvShowDetailState>(
      'Shoud emit TvShowDetailLoading, RecomendationLoading, TvShowDetailLoaded and RecomendationLoaded when get  Detail TvShows and Recommendation Success',
      build: () {
        when(mockGetTvShowDetail.execute(tId))
            .thenAnswer((_) async => Right(tTvShowDetail));
        when(mockGetTvShowRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvShows));
        return tvShowDetailBloc;
      },
      act: (bloc) => bloc.add(FetchTvShowDetail(tId)),
      expect: () => [
        TvShowDetailStateInit.copyWith(tvShowDetailState: RequestState.Loading),
        TvShowDetailStateInit.copyWith(
          tvShowRecommendationState: RequestState.Loading,
          tvShowDetail: tTvShowDetail,
          tvShowDetailState: RequestState.Loaded,
          message: '',
        ),
        TvShowDetailStateInit.copyWith(
          tvShowDetailState: RequestState.Loaded,
          tvShowDetail: tTvShowDetail,
          tvShowRecommendationState: RequestState.Loaded,
          tvShowRecommendations: tTvShows,
          message: '',
        ),
      ],
      verify: (_) {
        verify(mockGetTvShowDetail.execute(tId));
        verify(mockGetTvShowRecommendations.execute(tId));
      },
    );

    blocTest<TvShowDetailBloc, TvShowDetailState>(
      'Shoud emit TvShowDetailLoading, RecomendationLoading, TvShowDetailLoaded and RecommendationError when Get TvShowRecommendations Failed',
      build: () {
        when(mockGetTvShowDetail.execute(tId))
            .thenAnswer((_) async => Right(tTvShowDetail));
        when(mockGetTvShowRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ConnectionFailure('Failed')));
        return tvShowDetailBloc;
      },
      act: (bloc) => bloc.add(FetchTvShowDetail(tId)),
      expect: () => [
        TvShowDetailStateInit.copyWith(tvShowDetailState: RequestState.Loading),
        TvShowDetailStateInit.copyWith(
          tvShowRecommendationState: RequestState.Loading,
          tvShowDetail: tTvShowDetail,
          tvShowDetailState: RequestState.Loaded,
          message: '',
        ),
        TvShowDetailStateInit.copyWith(
          tvShowDetailState: RequestState.Loaded,
          tvShowDetail: tTvShowDetail,
          tvShowRecommendationState: RequestState.Error,
          message: 'Failed',
        ),
      ],
      verify: (_) {
        verify(mockGetTvShowDetail.execute(tId));
        verify(mockGetTvShowRecommendations.execute(tId));
      },
    );

    blocTest<TvShowDetailBloc, TvShowDetailState>(
      'Shoud emit TvShowDetailError when Get TvShow Detail Failed',
      build: () {
        when(mockGetTvShowDetail.execute(tId))
            .thenAnswer((_) async => Left(ConnectionFailure('Failed')));
        when(mockGetTvShowRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvShows));
        return tvShowDetailBloc;
      },
      act: (bloc) => bloc.add(FetchTvShowDetail(tId)),
      expect: () => [
        TvShowDetailStateInit.copyWith(tvShowDetailState: RequestState.Loading),
        TvShowDetailStateInit.copyWith(
          tvShowDetailState: RequestState.Error, 
          message: 'Failed'
        ),
      ],
      verify: (_) {
        verify(mockGetTvShowDetail.execute(tId));
        verify(mockGetTvShowRecommendations.execute(tId));
      },
    );
  });

  group('AddToWatchlist TvShow', () { 

    blocTest<TvShowDetailBloc, TvShowDetailState>(
      'Shoud emit WatchlistMessage and isAddedToWatchlist True when Success AddWatchlist',
      build: () {
        when(mockSaveWatchlist.execute(tTvShowDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        when(mockGetWatchlistStatus.execute(tTvShowDetail.id))
            .thenAnswer((_) async => true);
        return tvShowDetailBloc;
      },
      act: (bloc) => bloc.add(AddToWatchlist(tTvShowDetail)),
      expect: () => [
        TvShowDetailStateInit.copyWith(watchlistMessage: 'Added to Watchlist'),
        TvShowDetailStateInit.copyWith(
          watchlistMessage: 'Added to Watchlist', 
          isAddedToWatchlist: true
        ),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(tTvShowDetail));
        verify(mockGetWatchlistStatus.execute(tTvShowDetail.id));
      },
    );

    blocTest<TvShowDetailBloc, TvShowDetailState>(
      'Shoud emit watchlistMessage when Failed',
      build: () {
        when(mockSaveWatchlist.execute(tTvShowDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistStatus.execute(tTvShowDetail.id))
            .thenAnswer((_) async => false);
        return tvShowDetailBloc;
      },
      act: (bloc) => bloc.add(AddToWatchlist(tTvShowDetail)),
      expect: () => [
        TvShowDetailStateInit.copyWith(watchlistMessage: 'Failed'),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(tTvShowDetail));
        verify(mockGetWatchlistStatus.execute(tTvShowDetail.id));
      },
    );
  });

  group('RemoveFromWatchlist TvShow', () { 
    
    blocTest<TvShowDetailBloc, TvShowDetailState>(
      'Shoud emit WatchlistMessage and isAddedToWatchlist False when Success RemoveFromWatchlist',
      build: () {
        when(mockRemoveWatchlist.execute(tTvShowDetail))
            .thenAnswer((_) async => Right('Removed From Watchlist'));
        when(mockGetWatchlistStatus.execute(tTvShowDetail.id))
            .thenAnswer((_) async => false);
        return tvShowDetailBloc;
      },
      act: (bloc) => bloc.add(RemoveFromWatchlist(tTvShowDetail)),
      expect: () => [
        TvShowDetailStateInit.copyWith(
          watchlistMessage: 'Removed From Watchlist',
          isAddedToWatchlist: false
        ),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(tTvShowDetail));
        verify(mockGetWatchlistStatus.execute(tTvShowDetail.id));
      },
    );

    blocTest<TvShowDetailBloc, TvShowDetailState>(
      'Shoud emit watchlistMessage when Failed',
      build: () {
        when(mockRemoveWatchlist.execute(tTvShowDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistStatus.execute(tTvShowDetail.id))
            .thenAnswer((_) async => false);
        return tvShowDetailBloc;
      },
      act: (bloc) => bloc.add(RemoveFromWatchlist(tTvShowDetail)),
      expect: () => [
        TvShowDetailStateInit.copyWith(watchlistMessage: 'Failed'),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(tTvShowDetail));
        verify(mockGetWatchlistStatus.execute(tTvShowDetail.id));
      },
    );
  });

  group('LoadWatchlistStatus', () {
    blocTest<TvShowDetailBloc, TvShowDetailState>(
      'Should Emit AddWatchlistStatus True',
      build: () {
        when(mockGetWatchlistStatus.execute(tId))
          .thenAnswer((_) async => true);
        return tvShowDetailBloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistStatus(tId)),
      expect: () => [
        TvShowDetailStateInit.copyWith(
          isAddedToWatchlist: true
        ),
      ],
      verify: (_) {
        verify(mockGetWatchlistStatus.execute(tTvShowDetail.id));
      },
    );
  });
}
