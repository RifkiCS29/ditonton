// coverage:ignore-file
import 'dart:async';

import 'package:core/data/models/movie_table.dart';
import 'package:core/data/models/tv_show_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  static const String _tblWatchlistMovie = 'watchlist_movie';
  static const String _tblCacheMovie = 'cache_movie';
  static const String _tblWatchlistTvShow = 'watchlist_tv_show';
  static const String _tblCacheTvShow = 'cache_tv_show';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlistMovie (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE  $_tblCacheMovie (
        id INTEGER,
        title TEXT,
        overview TEXT,
        posterPath TEXT,
        category TEXT,
        idCacheMovie INTEGER PRIMARY KEY AUTOINCREMENT
      );
    ''');
    await db.execute('''
      CREATE TABLE  $_tblWatchlistTvShow (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE  $_tblCacheTvShow (
        id INTEGER,
        name TEXT,
        overview TEXT,
        posterPath TEXT,
        category TEXT,
        idCacheTvShow INTEGER PRIMARY KEY AUTOINCREMENT
      );
    ''');
  }

  Future<void> insertCacheTransactionMovies(
    List<MovieTable> movies, String category
  ) async {
    final db = await database;
    db!.transaction((txn) async {
      for(final movie in movies) {
        final movieJson = movie.toJson();
        movieJson['category'] = category;
        txn.insert(_tblCacheMovie, movieJson);
      }
    });
  }

  Future<List<Map<String, dynamic>>> getCacheMovies(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblCacheMovie,
      where: 'category = ?',
      whereArgs: [category],
    );

    return results;
  }

  Future<int> clearCacheMovies(String category) async {
    final db = await database;
    return await db!.delete(
      _tblCacheMovie,
      where: 'category = ?',
      whereArgs: [category],
    );
  }

  Future<int> insertWatchlistMovie(MovieTable movie) async {
    final db = await database;
    return await db!.insert(_tblWatchlistMovie, movie.toJson());
  }

  Future<int> removeWatchlistMovie(MovieTable movie) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlistMovie,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlistMovie,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlistMovie);

    return results;
  }

  //TV SHOW
  Future<void> insertCacheTransactionTvShows(
    List<TvShowTable> tvshows, String category
  ) async {
    final db = await database;
    db!.transaction((txn) async {
      for(final tvShow in tvshows) {
        final tvShowJson = tvShow.toJson();
        tvShowJson['category'] = category;
        txn.insert(_tblCacheTvShow, tvShowJson);
      }
    });
  }

  Future<List<Map<String, dynamic>>> getCacheTvShows(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblCacheTvShow,
      where: 'category = ?',
      whereArgs: [category],
    );

    return results;
  }

  Future<int> clearCacheTvShows(String category) async {
    final db = await database;
    return await db!.delete(
      _tblCacheTvShow,
      where: 'category = ?',
      whereArgs: [category],
    );
  }

  Future<int> insertWatchlistTvShow(TvShowTable tvShow) async {
    final db = await database;
    return await db!.insert(_tblWatchlistTvShow, tvShow.toJson());
  }

  Future<int> removeWatchlistTvShow(TvShowTable tvShow) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlistTvShow,
      where: 'id = ?',
      whereArgs: [tvShow.id],
    );
  }

  Future<Map<String, dynamic>?> getTvShowById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlistTvShow,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTvShows() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlistTvShow);

    return results;
  }
}
