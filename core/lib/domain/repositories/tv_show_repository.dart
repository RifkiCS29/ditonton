import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/entities/tv_show_detail.dart';

abstract class TvShowRepository {
  Future<Either<Failure, List<TvShow>>> getAiringTodayTvShows();
  Future<Either<Failure, List<TvShow>>> getPopularTvShows();
  Future<Either<Failure, List<TvShow>>> getTopRatedTvShows();
  Future<Either<Failure, TvShowDetail>> getTvShowDetail(int id);
  Future<Either<Failure, List<Episode>>> getTvShowSeasonEpisodes(int id, int seasonNumber);
  Future<Either<Failure, List<TvShow>>> getTvShowRecommendations(int id);
  Future<Either<Failure, List<TvShow>>> searchTvShows(String query);
  Future<Either<Failure, String>> saveWatchlistTvShow(TvShowDetail tvShow);
  Future<Either<Failure, String>> removeWatchlistTvShow(TvShowDetail tvShow);
  Future<bool> isAddedToWatchlistTvShow(int id);
  Future<Either<Failure, List<TvShow>>> getWatchlistTvShows();
}
