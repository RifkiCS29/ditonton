import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class GetTvShowSeasonEpisodes {
  final TvShowRepository repository;

  GetTvShowSeasonEpisodes(this.repository);

  Future<Either<Failure, List<Episode>>> execute(int id, int seasonNumber) {
    return repository.getTvShowSeasonEpisodes(id, seasonNumber);
  }
}
