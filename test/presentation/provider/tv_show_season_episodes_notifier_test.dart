import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/usecases/get_tv_show_season_episodes.dart';
import 'package:ditonton/presentation/provider/tv_show_season_episodes_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_show_season_episodes_notifier_test.mocks.dart';

@GenerateMocks([GetTvShowSeasonEpisodes])
void main() {
  late TvShowSeasonEpisodesNotifier provider;
  late MockGetTvShowSeasonEpisodes mockGetTvShowSeasonEpisodes;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvShowSeasonEpisodes = MockGetTvShowSeasonEpisodes();
    provider = TvShowSeasonEpisodesNotifier(getTvShowSeasonEpisodes: mockGetTvShowSeasonEpisodes)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tEpisodeModel = Episode(
    airDate: '2021-09-17',
    episodeNumber: 1,
    id: 1922715,
    name: 'Red Light, Green Light',
    overview: 'Hoping to win easy money, a broke and desperate Gi-hun agrees to take part in an enigmatic game. Not long into the first round, unforeseen horrors unfold.',
    productionCode: '',
    seasonNumber: 1,
    stillPath: '/vMFJS9LIUUAmQ1thq4vJ7iHKwRz.jpg',
    voteAverage: 8.1,
    voteCount: 51,
  );
  final tEpisodeList = <Episode>[tEpisodeModel];
  final tId = 1;
  final tSeasonNumber = 1;

  group('Tv Show Season Episodes', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTvShowSeasonEpisodes.execute(tId, tSeasonNumber))
          .thenAnswer((_) async => Right(tEpisodeList));
      // act
      provider.fetchTvShowSeasonEpisodes(tId, tSeasonNumber);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change episode data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTvShowSeasonEpisodes.execute(tId, tSeasonNumber))
          .thenAnswer((_) async => Right(tEpisodeList));
      // act
      await provider.fetchTvShowSeasonEpisodes(tId, tSeasonNumber);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.episode, tEpisodeList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvShowSeasonEpisodes.execute(tId, tSeasonNumber))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvShowSeasonEpisodes(tId, tSeasonNumber);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
