import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/domain/usecases/get_tv_show_season_episodes.dart';
import 'package:tv_show/presentation/bloc/tv_show_season_episodes/tv_show_season_episodes_bloc.dart';

import 'tv_show_season_episodes_bloc_test.mocks.dart';

@GenerateMocks([GetTvShowSeasonEpisodes])
void main() {
  late MockGetTvShowSeasonEpisodes mockGetTvShowSeasonEpisodes;
  late TvShowSeasonEpisodesBloc tvShowSeasonEpisodesBloc;

  setUp(() {
    mockGetTvShowSeasonEpisodes = MockGetTvShowSeasonEpisodes();
    tvShowSeasonEpisodesBloc = TvShowSeasonEpisodesBloc(mockGetTvShowSeasonEpisodes);
  });
  
  const tId = 1;
  const tSeasonNumber = 1;
  final tEpisode = Episode(
    airDate: 'airDate',
    episodeNumber: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    productionCode: 'productionCode',
    seasonNumber: 1,
    stillPath: 'stillPath',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tEpisodeList = <Episode>[tEpisode];

  group('Season Episodes Tv Show', () {
    test('Initial state should be empty', () {
      expect(tvShowSeasonEpisodesBloc.state, TvShowSeasonEpisodesEmpty());
    });

    blocTest<TvShowSeasonEpisodesBloc, TvShowSeasonEpisodesState> (
      'Should emit [TvShowSeasonEpisodesLoading, TvShowSeasonEpisodesLoaded] when data is gotten successfully',
      build: () {
        when(mockGetTvShowSeasonEpisodes.execute(tId, tSeasonNumber))
          .thenAnswer((_) async => Right(tEpisodeList));
        return tvShowSeasonEpisodesBloc;
      },
      act: (bloc) => bloc.add(FetchTvShowSeasonEpisodesEvent(tId, tSeasonNumber)),
      expect: () => [
        TvShowSeasonEpisodesLoading(),
        TvShowSeasonEpisodesLoaded(tEpisodeList),
      ],
      verify: (bloc) {
        verify(mockGetTvShowSeasonEpisodes.execute(tId, tSeasonNumber));
      },
    );

    blocTest<TvShowSeasonEpisodesBloc, TvShowSeasonEpisodesState> (
      'Should emit [TvShowSeasonEpisodesLoading, TvShowSeasonEpisodesLoaded[], TvShowSeasonEpisodesEmpty] when data is gotten successfully',
      build: () {
        when(mockGetTvShowSeasonEpisodes.execute(tId, tSeasonNumber))
          .thenAnswer((_) async => Right(<Episode>[]));
        return tvShowSeasonEpisodesBloc;
      },
      act: (bloc) => bloc.add(FetchTvShowSeasonEpisodesEvent(tId, tSeasonNumber)),
      expect: () => [
        TvShowSeasonEpisodesLoading(),
        TvShowSeasonEpisodesLoaded(const <Episode>[]),
        TvShowSeasonEpisodesEmpty(),
      ],
      verify: (bloc) {
        verify(mockGetTvShowSeasonEpisodes.execute(tId, tSeasonNumber));
      },
    );

    blocTest<TvShowSeasonEpisodesBloc, TvShowSeasonEpisodesState> (
      'Should emit [TvShowSeasonEpisodesLoading, TvShowSeasonEpisodesError] when get Failure',
      build: () {
        when(mockGetTvShowSeasonEpisodes.execute(tId, tSeasonNumber))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return tvShowSeasonEpisodesBloc;
      },
      act: (bloc) => bloc.add(FetchTvShowSeasonEpisodesEvent(tId, tSeasonNumber)),
      expect: () => [
        TvShowSeasonEpisodesLoading(),
        TvShowSeasonEpisodesError('Failed'),
      ],
      verify: (_) {
        verify(mockGetTvShowSeasonEpisodes.execute(tId, tSeasonNumber));
      },
    );

    blocTest<TvShowSeasonEpisodesBloc, TvShowSeasonEpisodesState> (
      'Should emit [TvShowSeasonEpisodesLoading, TvShowSeasonEpisodesError] when get Failure TlsException',
      build: () {
        when(mockGetTvShowSeasonEpisodes.execute(tId, tSeasonNumber))
            .thenAnswer((_) async => Left(CommonFailure('Certificated Not Valid:\n')));
        return tvShowSeasonEpisodesBloc;
      },
      act: (bloc) => bloc.add(FetchTvShowSeasonEpisodesEvent(tId, tSeasonNumber)),
      expect: () => [
        TvShowSeasonEpisodesLoading(),
        TvShowSeasonEpisodesError('Certificated Not Valid:\n'),
      ],
      verify: (_) {
        verify(mockGetTvShowSeasonEpisodes.execute(tId, tSeasonNumber));
      },
    );
  });
}
