import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/domain/usecases/get_airing_today_tv_shows.dart';
import 'package:tv_show/domain/usecases/get_popular_tv_shows.dart';
import 'package:tv_show/domain/usecases/get_top_rated_tv_shows.dart';
import 'package:tv_show/presentation/bloc/tv_show_list_bloc/tv_show_list_bloc.dart';

import 'tv_show_list_bloc_test.mocks.dart';

@GenerateMocks([GetAiringTodayTvShows, GetPopularTvShows, GetTopRatedTvShows])
void main() {
  late AiringTodayTvShowListBloc airingTodayTvShowListBloc;
  late MockGetAiringTodayTvShows mockGetAiringTodayTvShows;
  late PopularTvShowListBloc popularTvShowListBloc;
  late MockGetPopularTvShows mockGetPopularTvShows;
  late TopRatedTvShowListBloc topRatedTvShowListBloc;
  late MockGetTopRatedTvShows mockGetTopRatedTvShows;

  setUp(() {
    mockGetAiringTodayTvShows = MockGetAiringTodayTvShows();
    airingTodayTvShowListBloc = AiringTodayTvShowListBloc(mockGetAiringTodayTvShows);
    mockGetPopularTvShows = MockGetPopularTvShows();
    popularTvShowListBloc = PopularTvShowListBloc(mockGetPopularTvShows);
    mockGetTopRatedTvShows = MockGetTopRatedTvShows();
    topRatedTvShowListBloc = TopRatedTvShowListBloc(mockGetTopRatedTvShows);
  });

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
  final tTvShowList = <TvShow>[tTvShow];

  group('Airing Today Tv Show list', () {
    test('Initial state should be empty', () {
      expect(airingTodayTvShowListBloc.state, TvShowListEmpty());
    });

    blocTest<AiringTodayTvShowListBloc, TvShowListState> (
      'Should emit [TvShowListLoading, TvShowListLoaded] when data is gotten successfully',
      build: () {
        when(mockGetAiringTodayTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
        return airingTodayTvShowListBloc;
      },
      act: (bloc) => bloc.add(TvShowListEvent()),
      expect: () => [
        TvShowListLoading(),
        TvShowListLoaded(tTvShowList),
      ],
      verify: (bloc) {
        verify(mockGetAiringTodayTvShows.execute());
      },
    );

    blocTest<AiringTodayTvShowListBloc, TvShowListState> (
      'Should emit [TvShowListLoading, TvShowListError] when get Failure',
      build: () {
        when(mockGetAiringTodayTvShows.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return airingTodayTvShowListBloc;
      },
      act: (bloc) => bloc.add(TvShowListEvent()),
      expect: () => [
        TvShowListLoading(),
        TvShowListError('Failed'),
      ],
      verify: (_) {
        verify(mockGetAiringTodayTvShows.execute());
      },
    );
  });

  group('Popular Tv Show list', () {
    test('Initial state should be empty', () {
      expect(popularTvShowListBloc.state, TvShowListEmpty());
    });

    blocTest<PopularTvShowListBloc, TvShowListState> (
      'Should emit [TvShowListLoading, TvShowListLoaded] when data is gotten successfully',
      build: () {
        when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
        return popularTvShowListBloc;
      },
      act: (bloc) => bloc.add(TvShowListEvent()),
      expect: () => [
        TvShowListLoading(),
        TvShowListLoaded(tTvShowList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTvShows.execute());
      },
    );

    blocTest<PopularTvShowListBloc, TvShowListState> (
      'Should emit [TvShowListLoading, TvShowListError] when get Failure',
      build: () {
        when(mockGetPopularTvShows.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return popularTvShowListBloc;
      },
      act: (bloc) => bloc.add(TvShowListEvent()),
      expect: () => [
        TvShowListLoading(),
        TvShowListError('Failed'),
      ],
      verify: (_) {
        verify(mockGetPopularTvShows.execute());
      },
    );
  });

  group('Top rated Tv Show list', () {
    test('Initial state should be empty', () {
      expect(topRatedTvShowListBloc.state, TvShowListEmpty());
    });

    blocTest<TopRatedTvShowListBloc, TvShowListState> (
      'Should emit [TvShowListLoading, TvShowListLoaded] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
        return topRatedTvShowListBloc;
      },
      act: (bloc) => bloc.add(TvShowListEvent()),
      expect: () => [
        TvShowListLoading(),
        TvShowListLoaded(tTvShowList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTvShows.execute());
      },
    );

    blocTest<TopRatedTvShowListBloc, TvShowListState> (
      'Should emit [TvShowListLoading, TvShowListError] when get Failure',
      build: () {
        when(mockGetTopRatedTvShows.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return topRatedTvShowListBloc;
      },
      act: (bloc) => bloc.add(TvShowListEvent()),
      expect: () => [
        TvShowListLoading(),
        TvShowListError('Failed'),
      ],
      verify: (_) {
        verify(mockGetTopRatedTvShows.execute());
      },
    );
  });
}
