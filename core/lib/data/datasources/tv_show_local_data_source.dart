import 'package:core/common/exception.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/models/tv_show_table.dart';

abstract class TvShowLocalDataSource {
  Future<String> insertWatchlistTvShow(TvShowTable tvShow);
  Future<String> removeWatchlistTvShow(TvShowTable tvShow);
  Future<TvShowTable?> getTvShowById(int id);
  Future<List<TvShowTable>> getWatchlistTvShows();
  Future<void> cacheNowPlayingTvShows(List<TvShowTable> tvShows);
  Future<List<TvShowTable>> getCachedNowPlayingTvShows();
  Future<void> cachePopularTvShows(List<TvShowTable> tvShows);
  Future<List<TvShowTable>> getCachedPopularTvShows();
  Future<void> cacheTopRatedTvShows(List<TvShowTable> tvShows);
  Future<List<TvShowTable>> getCachedTopRatedTvShows();
}

class TvShowLocalDataSourceImpl implements TvShowLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvShowLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlistTvShow(TvShowTable tvShow) async {
    try {
      await databaseHelper.insertWatchlistTvShow(tvShow);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistTvShow(TvShowTable tvShow) async {
    try {
      await databaseHelper.removeWatchlistTvShow(tvShow);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvShowTable?> getTvShowById(int id) async {
    final result = await databaseHelper.getTvShowById(id);
    if (result != null) {
      return TvShowTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvShowTable>> getWatchlistTvShows() async {
    final result = await databaseHelper.getWatchlistTvShows();
    return result.map((data) => TvShowTable.fromMap(data)).toList();
  }

  @override
  Future<void> cacheNowPlayingTvShows(List<TvShowTable> tvShows) async {
    await databaseHelper.clearCacheTvShows('now playing');
    await databaseHelper.insertCacheTransactionTvShows(tvShows, 'now playing');
  }

  @override
  Future<List<TvShowTable>> getCachedNowPlayingTvShows() async {
    final result = await databaseHelper.getCacheTvShows('now playing');
    if (result.length > 0) {
      return result.map((data) => TvShowTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<void> cachePopularTvShows(List<TvShowTable> tvShows) async {
    await databaseHelper.clearCacheTvShows('popular');
    await databaseHelper.insertCacheTransactionTvShows(tvShows, 'popular');
  }

  @override
  Future<List<TvShowTable>> getCachedPopularTvShows() async {
    final result = await databaseHelper.getCacheTvShows('popular');
    if (result.length > 0) {
      return result.map((data) => TvShowTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<void> cacheTopRatedTvShows(List<TvShowTable> tvShows) async {
    await databaseHelper.clearCacheTvShows('top rated');
    await databaseHelper.insertCacheTransactionTvShows(tvShows, 'top rated');
  }

  @override
  Future<List<TvShowTable>> getCachedTopRatedTvShows() async {
    final result = await databaseHelper.getCacheTvShows('top rated');
    if (result.length > 0) {
      return result.map((data) => TvShowTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }
}
