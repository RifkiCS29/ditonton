import 'package:core/data/models/season_model.dart';
import 'package:core/domain/entities/tv_show_detail.dart';
import 'package:equatable/equatable.dart';
import 'genre_model.dart';

class TvShowDetailResponse  extends Equatable {
    TvShowDetailResponse({
        required this.backdropPath,
        required this.episodeRunTime,
        required this.firstAirDate,
        required this.genres,
        required this.homepage,
        required this.id,
        required this.inProduction,
        required this.lastAirDate,
        required this.name,
        required this.numberOfEpisodes,
        required this.numberOfSeasons,
        required this.originalName,
        required this.overview,
        required this.popularity,
        required this.posterPath,
        required this.seasons,
        required this.status,
        required this.tagline,
        required this.type,
        required this.voteAverage,
        required this.voteCount,
    });

    final String? backdropPath;
    final List<int> episodeRunTime;
    final String firstAirDate;
    final List<GenreModel> genres;
    final String homepage;
    final int id;
    final bool inProduction;
    final String lastAirDate;
    final String name;
    final int numberOfEpisodes;
    final int numberOfSeasons;
    final String originalName;
    final String overview;
    final double popularity;
    final String posterPath;
    final List<SeasonModel> seasons;
    final String status;
    final String? tagline;
    final String type;
    final double voteAverage;
    final int voteCount;

    factory TvShowDetailResponse.fromJson(Map<String, dynamic> json) => 
      TvShowDetailResponse(
        backdropPath: json["backdrop_path"],
        episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
        firstAirDate: json["first_air_date"],
        genres: List<GenreModel>.from(json["genres"].map((x) => GenreModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        lastAirDate: json["last_air_date"],
        name: json["name"],
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        seasons: List<SeasonModel>.from(json["seasons"].map((x) => SeasonModel.fromJson(x))),
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

    Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
        "first_air_date": firstAirDate,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "in_production": inProduction,
        "last_air_date": lastAirDate,
        "name": name,
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
        "status": status,
        "tagline": tagline,
        "type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };

    TvShowDetail toEntity() {
      return TvShowDetail(
        backdropPath: this.backdropPath,
        firstAirDate: this.firstAirDate,
        genres: this.genres.map((genre) => genre.toEntity()).toList(),
        id: this.id,
        name: this.name,
        originalName: this.originalName,
        overview: this.overview,
        posterPath: this.posterPath,
        seasons: this.seasons.map((genre) => genre.toEntity()).toList(),
        tagline: this.tagline,
        voteAverage: this.voteAverage,
        voteCount: this.voteCount
    );
  }

  @override
  List<Object?> get props => [
    backdropPath,
    episodeRunTime,
    firstAirDate,
    genres,
    homepage,
    id,
    inProduction,
    lastAirDate,
    name,
    numberOfEpisodes,
    numberOfSeasons,
    originalName,
    overview,
    popularity,
    posterPath,
    seasons,
    status,
    tagline,
    type,
    voteAverage,
    voteCount
  ];
}
