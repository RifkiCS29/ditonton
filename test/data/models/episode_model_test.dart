import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tEpisodeModel = EpisodeModel(
      airDate: "2021-09-17",
      episodeNumber: 1,
      id: 1922715,
      name: "Red Light, Green Light",
      overview:
          "Hoping to win easy money, a broke and desperate Gi-hun agrees to take part in an enigmatic game. Not long into the first round, unforeseen horrors unfold.",
      productionCode: "",
      seasonNumber: 1,
      stillPath: "/vMFJS9LIUUAmQ1thq4vJ7iHKwRz.jpg",
      voteAverage: 8.1,
      voteCount: 51
  );

  final tEpisode = Episode(
      airDate: "2021-09-17",
      episodeNumber: 1,
      id: 1922715,
      name: "Red Light, Green Light",
      overview:
          "Hoping to win easy money, a broke and desperate Gi-hun agrees to take part in an enigmatic game. Not long into the first round, unforeseen horrors unfold.",
      productionCode: "",
      seasonNumber: 1,
      stillPath: "/vMFJS9LIUUAmQ1thq4vJ7iHKwRz.jpg",
      voteAverage: 8.1,
      voteCount: 51
  );

  test('should be a subclass Episode entity', () async {
    final result = tEpisodeModel.toEntity();
    expect(result, tEpisode);
  });
}