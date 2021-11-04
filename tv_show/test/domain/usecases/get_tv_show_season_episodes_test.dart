import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:tv_show/domain/usecases/get_tv_show_season_episodes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvShowSeasonEpisodes usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetTvShowSeasonEpisodes(mockTvShowRepository);
  });

  final tId = 1;
  final tSeasonNumber = 1;
  final tEpisodes = <Episode>[];

  test('should get list of Tv Show Season Episodes from the repository',
      () async {
    // arrange
    when(mockTvShowRepository.getTvShowSeasonEpisodes(tId, tSeasonNumber))
        .thenAnswer((_) async => Right(tEpisodes));
    // act
    final result = await usecase.execute(tId, tSeasonNumber);
    // assert
    expect(result, Right(tEpisodes));
  });
}
