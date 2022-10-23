import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/season_model.dart';
import 'package:core/data/models/tv_show_detail_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/season.dart';
import 'package:core/domain/entities/tv_show_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTvShowDetailModel = TvShowDetailResponse(
    backdropPath: 'backdropPath',
    episodeRunTime: [1, 2, 3],
    firstAirDate: 'firstAirDate',
    genres: [GenreModel(id: 1, name: 'Action')],
    homepage: 'homepage',
    id: 1,
    inProduction: false,
    lastAirDate: 'lastAirDate',
    name: 'name',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    seasons: [
      SeasonModel(
        airDate: 'airDate', 
        episodeCount: 1,
        id: 1, 
        name: 'name', 
        overview: 'overview', 
        posterPath: 'posterPath', 
        seasonNumber: 1,
      )
    ],
    status: 'status',
    tagline: 'tagline',
    type: 'type',
    voteAverage: 1,
    voteCount: 1,
  );

  const tTvShowDetail = TvShowDetail(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    name: 'name',
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    seasons: [
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

  final tTvShowDetailJson = {
    'backdrop_path': 'backdropPath',
    'episode_run_time': [1, 2, 3],
    'first_air_date': 'firstAirDate',
    'genres': [{'id': 1, 'name': 'Action'}],
    'homepage': 'homepage',
    'id': 1,
    'in_production': false,
    'last_air_date': 'lastAirDate',
    'name': 'name',
    'number_of_episodes': 1,
    'number_of_seasons': 1,
    'original_name': 'originalName',
    'overview': 'overview',
    'popularity': 1.0,
    'poster_path': 'posterPath',
    'seasons': [
      {
        'air_date': 'airDate', 
        'episode_count': 1,
        'id': 1, 
        'name': 'name', 
        'overview': 'overview', 
        'poster_path': 'posterPath', 
        'season_number': 1
      }
    ],
    'status': 'status',
    'tagline': 'tagline',
    'type': 'type',
    'vote_average': 1,
    'vote_count': 1,
  };

  test('should be a subclass Tv Show Detail entity', () async {
    final result = tTvShowDetailModel.toEntity();
    expect(result, tTvShowDetail);
  });

  test('should be a subclass Tv Show Detail Json', () async {
    final result = tTvShowDetailModel.toJson();
    expect(result, tTvShowDetailJson);
  });
}