import 'dart:convert';
import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/episode_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

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

  final tEpisodeResponseModel = EpisodeResponse(episodes: <EpisodeModel>[tEpisodeModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_show_episodes.json'));
      // act
      final result = EpisodeResponse.fromJson(jsonMap);
      // assert
      expect(result, tEpisodeResponseModel);
    });
  });
}