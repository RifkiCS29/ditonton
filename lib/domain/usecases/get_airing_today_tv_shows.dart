import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class GetAiringTodayTvShows {
  final TvShowRepository repository;

  GetAiringTodayTvShows(this.repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getAiringTodayTvShows();
  }
}
