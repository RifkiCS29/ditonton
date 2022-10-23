import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class TvShowDetail extends Equatable {
  const TvShowDetail({
        required this.backdropPath,
        required this.firstAirDate,
        required this.genres,
        required this.id,
        required this.name,
        required this.originalName,
        required this.overview,
        required this.posterPath,
        required this.seasons,
        required this.tagline,
        required this.voteAverage,
        required this.voteCount,
  });


  final String? backdropPath;
  final String firstAirDate;
  final List<Genre> genres;
  final int id;
  final String name;
  final String originalName;
  final String overview;
  final String posterPath;
  final List<Season> seasons;
  final String? tagline;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genres,
        id,
        name,
        originalName,
        overview,
        posterPath,
        seasons,
        tagline,
        voteAverage,
        voteCount
      ];
}
