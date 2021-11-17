import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/domain/usecases/get_airing_today_tv_shows.dart';
import 'package:tv_show/presentation/bloc/airing_today_tv_shows_bloc/airing_today_tv_shows_bloc.dart';

import 'airing_today_tv_shows_bloc_test.mocks.dart';

@GenerateMocks([GetAiringTodayTvShows])
void main() {
  late MockGetAiringTodayTvShows mockGetAiringTodayTvShows;
  late AiringTodayTvShowsBloc airingTodayTvShowsBloc;

  setUp(() {
    mockGetAiringTodayTvShows = MockGetAiringTodayTvShows();
    airingTodayTvShowsBloc = AiringTodayTvShowsBloc(mockGetAiringTodayTvShows);
  });
  
  final tTvShow = TvShow(
      backdropPath: "/xAKMj134XHQVNHLC6rWsccLMenG.jpg",
      firstAirDate: "2021-10-12",
      genreIds: [10765, 35, 80],
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

  group('Airing Today Tv Shows', () {
    test('Initial state should be empty', () {
      expect(airingTodayTvShowsBloc.state, AiringTodayTvShowsEmpty());
    });

    blocTest<AiringTodayTvShowsBloc, AiringTodayTvShowsState> (
      'Should emit [AiringTodayTvShowsLoading, AiringTodayTvShowsLoaded] when data is gotten successfully',
      build: () {
        when(mockGetAiringTodayTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
        return airingTodayTvShowsBloc;
      },
      act: (bloc) => bloc.add(AiringTodayTvShowsEvent()),
      expect: () => [
        AiringTodayTvShowsLoading(),
        AiringTodayTvShowsLoaded(tTvShowList),
      ],
      verify: (bloc) {
        verify(mockGetAiringTodayTvShows.execute());
      },
    );

    blocTest<AiringTodayTvShowsBloc, AiringTodayTvShowsState> (
      'Should emit [AiringTodayTvShowsLoading, AiringTodayTvShowsLoaded[], AiringTodayTvShowsEmpty] when data is gotten successfully',
      build: () {
        when(mockGetAiringTodayTvShows.execute())
          .thenAnswer((_) async => Right(<TvShow>[]));
        return airingTodayTvShowsBloc;
      },
      act: (bloc) => bloc.add(AiringTodayTvShowsEvent()),
      expect: () => [
        AiringTodayTvShowsLoading(),
        AiringTodayTvShowsLoaded(<TvShow>[]),
        AiringTodayTvShowsEmpty(),
      ],
      verify: (bloc) {
        verify(mockGetAiringTodayTvShows.execute());
      },
    );

    blocTest<AiringTodayTvShowsBloc, AiringTodayTvShowsState> (
      'Should emit [AiringTodayTvShowsLoading, AiringTodayTvShowsError] when get Failure',
      build: () {
        when(mockGetAiringTodayTvShows.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return airingTodayTvShowsBloc;
      },
      act: (bloc) => bloc.add(AiringTodayTvShowsEvent()),
      expect: () => [
        AiringTodayTvShowsLoading(),
        AiringTodayTvShowsError('Failed'),
      ],
      verify: (_) {
        verify(mockGetAiringTodayTvShows.execute());
      },
    );
  });
}
