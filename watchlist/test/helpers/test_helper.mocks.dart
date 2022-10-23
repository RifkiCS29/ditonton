// Mocks generated by Mockito 5.0.16 from annotations
// in watchlist/test/helpers/test_helper.dart.
// Do not manually edit this file.

import 'dart:async' as _i7;
import 'dart:convert' as _i27;
import 'dart:typed_data' as _i28;

import 'package:core/common/failure.dart' as _i8;
import 'package:core/common/network_info.dart' as _i24;
import 'package:core/data/datasources/db/database_helper.dart' as _i25;
import 'package:core/data/datasources/movie_local_data_source.dart' as _i13;
import 'package:core/data/datasources/movie_remote_data_source.dart' as _i11;
import 'package:core/data/datasources/tv_show_local_data_source.dart' as _i22;
import 'package:core/data/datasources/tv_show_remote_data_source.dart' as _i19;
import 'package:core/data/models/episode_model.dart' as _i21;
import 'package:core/data/models/movie_detail_model.dart' as _i3;
import 'package:core/data/models/movie_model.dart' as _i12;
import 'package:core/data/models/movie_table.dart' as _i14;
import 'package:core/data/models/tv_show_detail_model.dart' as _i4;
import 'package:core/data/models/tv_show_model.dart' as _i20;
import 'package:core/data/models/tv_show_table.dart' as _i23;
import 'package:core/domain/entities/episode.dart' as _i18;
import 'package:core/domain/entities/movie.dart' as _i9;
import 'package:core/domain/entities/movie_detail.dart' as _i10;
import 'package:core/domain/entities/tv_show.dart' as _i16;
import 'package:core/domain/entities/tv_show_detail.dart' as _i17;
import 'package:core/domain/repositories/movie_repository.dart' as _i6;
import 'package:core/domain/repositories/tv_show_repository.dart' as _i15;
import 'package:dartz/dartz.dart' as _i2;
import 'package:http/http.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i26;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeMovieDetailResponse_1 extends _i1.Fake
    implements _i3.MovieDetailResponse {}

class _FakeTvShowDetailResponse_2 extends _i1.Fake
    implements _i4.TvShowDetailResponse {}

class _FakeResponse_3 extends _i1.Fake implements _i5.Response {}

class _FakeStreamedResponse_4 extends _i1.Fake implements _i5.StreamedResponse {
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i6.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getPopularMovies, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, _i10.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
          returnValue: Future<_i2.Either<_i8.Failure, _i10.MovieDetail>>.value(
              _FakeEither_0<_i8.Failure, _i10.MovieDetail>())) as _i7
          .Future<_i2.Either<_i8.Failure, _i10.MovieDetail>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getMovieRecommendations(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> saveWatchlistMovie(
          _i10.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlistMovie, [movie]),
              returnValue: Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither_0<_i8.Failure, String>()))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> removeWatchlistMovie(
          _i10.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistMovie, [movie]),
              returnValue: Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither_0<_i8.Failure, String>()))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<bool> isAddedToWatchlistMovie(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlistMovie, [id]),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
}

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDataSource extends _i1.Mock
    implements _i11.MovieRemoteDataSource {
  MockMovieRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i12.MovieModel>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
              returnValue:
                  Future<List<_i12.MovieModel>>.value(<_i12.MovieModel>[]))
          as _i7.Future<List<_i12.MovieModel>>);
  @override
  _i7.Future<List<_i12.MovieModel>> getPopularMovies() => (super.noSuchMethod(
          Invocation.method(#getPopularMovies, []),
          returnValue: Future<List<_i12.MovieModel>>.value(<_i12.MovieModel>[]))
      as _i7.Future<List<_i12.MovieModel>>);
  @override
  _i7.Future<List<_i12.MovieModel>> getTopRatedMovies() => (super.noSuchMethod(
          Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<List<_i12.MovieModel>>.value(<_i12.MovieModel>[]))
      as _i7.Future<List<_i12.MovieModel>>);
  @override
  _i7.Future<_i3.MovieDetailResponse> getMovieDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
              returnValue: Future<_i3.MovieDetailResponse>.value(
                  _FakeMovieDetailResponse_1()))
          as _i7.Future<_i3.MovieDetailResponse>);
  @override
  _i7.Future<List<_i12.MovieModel>> getMovieRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
              returnValue:
                  Future<List<_i12.MovieModel>>.value(<_i12.MovieModel>[]))
          as _i7.Future<List<_i12.MovieModel>>);
  @override
  _i7.Future<List<_i12.MovieModel>> searchMovies(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
              returnValue:
                  Future<List<_i12.MovieModel>>.value(<_i12.MovieModel>[]))
          as _i7.Future<List<_i12.MovieModel>>);
}

/// A class which mocks [MovieLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieLocalDataSource extends _i1.Mock
    implements _i13.MovieLocalDataSource {
  MockMovieLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<String> insertWatchlistMovie(_i14.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlistMovie, [movie]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<String> removeWatchlistMovie(_i14.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistMovie, [movie]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i14.MovieTable?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: Future<_i14.MovieTable?>.value())
          as _i7.Future<_i14.MovieTable?>);
  @override
  _i7.Future<List<_i14.MovieTable>> getWatchlistMovies() => (super.noSuchMethod(
          Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<List<_i14.MovieTable>>.value(<_i14.MovieTable>[]))
      as _i7.Future<List<_i14.MovieTable>>);
  @override
  _i7.Future<void> cacheNowPlayingMovies(List<_i14.MovieTable>? movies) =>
      (super.noSuchMethod(Invocation.method(#cacheNowPlayingMovies, [movies]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<List<_i14.MovieTable>> getCachedNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getCachedNowPlayingMovies, []),
              returnValue:
                  Future<List<_i14.MovieTable>>.value(<_i14.MovieTable>[]))
          as _i7.Future<List<_i14.MovieTable>>);
  @override
  _i7.Future<void> cachePopularMovies(List<_i14.MovieTable>? movies) =>
      (super.noSuchMethod(Invocation.method(#cachePopularMovies, [movies]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<List<_i14.MovieTable>> getCachedPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getCachedPopularMovies, []),
              returnValue:
                  Future<List<_i14.MovieTable>>.value(<_i14.MovieTable>[]))
          as _i7.Future<List<_i14.MovieTable>>);
  @override
  _i7.Future<void> cacheTopRatedMovies(List<_i14.MovieTable>? movies) =>
      (super.noSuchMethod(Invocation.method(#cacheTopRatedMovies, [movies]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<List<_i14.MovieTable>> getCachedTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getCachedTopRatedMovies, []),
              returnValue:
                  Future<List<_i14.MovieTable>>.value(<_i14.MovieTable>[]))
          as _i7.Future<List<_i14.MovieTable>>);
}

/// A class which mocks [TvShowRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvShowRepository extends _i1.Mock implements _i15.TvShowRepository {
  MockTvShowRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i16.TvShow>>>
      getAiringTodayTvShows() => (super.noSuchMethod(
          Invocation.method(#getAiringTodayTvShows, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i16.TvShow>>>.value(
              _FakeEither_0<_i8.Failure, List<_i16.TvShow>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i16.TvShow>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i16.TvShow>>> getPopularTvShows() =>
      (super.noSuchMethod(Invocation.method(#getPopularTvShows, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i16.TvShow>>>.value(
              _FakeEither_0<_i8.Failure, List<_i16.TvShow>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i16.TvShow>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i16.TvShow>>> getTopRatedTvShows() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTvShows, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i16.TvShow>>>.value(
              _FakeEither_0<_i8.Failure, List<_i16.TvShow>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i16.TvShow>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, _i17.TvShowDetail>> getTvShowDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowDetail, [id]),
          returnValue: Future<_i2.Either<_i8.Failure, _i17.TvShowDetail>>.value(
              _FakeEither_0<_i8.Failure, _i17.TvShowDetail>())) as _i7
          .Future<_i2.Either<_i8.Failure, _i17.TvShowDetail>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i18.Episode>>>
      getTvShowSeasonEpisodes(int? id, int? seasonNumber) =>
          (super.noSuchMethod(
              Invocation.method(#getTvShowSeasonEpisodes, [id, seasonNumber]),
              returnValue:
                  Future<_i2.Either<_i8.Failure, List<_i18.Episode>>>.value(
                      _FakeEither_0<_i8.Failure, List<_i18.Episode>>())) as _i7
              .Future<_i2.Either<_i8.Failure, List<_i18.Episode>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i16.TvShow>>>
      getTvShowRecommendations(int? id) => (super.noSuchMethod(
          Invocation.method(#getTvShowRecommendations, [id]),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i16.TvShow>>>.value(
              _FakeEither_0<_i8.Failure, List<_i16.TvShow>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i16.TvShow>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i16.TvShow>>> searchTvShows(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvShows, [query]),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i16.TvShow>>>.value(
              _FakeEither_0<_i8.Failure, List<_i16.TvShow>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i16.TvShow>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> saveWatchlistTvShow(
          _i17.TvShowDetail? tvShow) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlistTvShow, [tvShow]),
              returnValue: Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither_0<_i8.Failure, String>()))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> removeWatchlistTvShow(
          _i17.TvShowDetail? tvShow) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistTvShow, [tvShow]),
              returnValue: Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither_0<_i8.Failure, String>()))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<bool> isAddedToWatchlistTvShow(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlistTvShow, [id]),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i16.TvShow>>>
      getWatchlistTvShows() => (super.noSuchMethod(
          Invocation.method(#getWatchlistTvShows, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i16.TvShow>>>.value(
              _FakeEither_0<_i8.Failure, List<_i16.TvShow>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i16.TvShow>>>);
}

/// A class which mocks [TvShowRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvShowRemoteDataSource extends _i1.Mock
    implements _i19.TvShowRemoteDataSource {
  MockTvShowRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i20.TvShowModel>> getAiringTodayTvShows() =>
      (super.noSuchMethod(Invocation.method(#getAiringTodayTvShows, []),
              returnValue:
                  Future<List<_i20.TvShowModel>>.value(<_i20.TvShowModel>[]))
          as _i7.Future<List<_i20.TvShowModel>>);
  @override
  _i7.Future<List<_i20.TvShowModel>> getPopularTvShows() =>
      (super.noSuchMethod(Invocation.method(#getPopularTvShows, []),
              returnValue:
                  Future<List<_i20.TvShowModel>>.value(<_i20.TvShowModel>[]))
          as _i7.Future<List<_i20.TvShowModel>>);
  @override
  _i7.Future<List<_i20.TvShowModel>> getTopRatedTvShows() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTvShows, []),
              returnValue:
                  Future<List<_i20.TvShowModel>>.value(<_i20.TvShowModel>[]))
          as _i7.Future<List<_i20.TvShowModel>>);
  @override
  _i7.Future<_i4.TvShowDetailResponse> getTvShowDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowDetail, [id]),
              returnValue: Future<_i4.TvShowDetailResponse>.value(
                  _FakeTvShowDetailResponse_2()))
          as _i7.Future<_i4.TvShowDetailResponse>);
  @override
  _i7.Future<List<_i21.EpisodeModel>> getTvShowSeasonEpisodes(
          int? id, int? seasonNumber) =>
      (super.noSuchMethod(
              Invocation.method(#getTvShowSeasonEpisodes, [id, seasonNumber]),
              returnValue:
                  Future<List<_i21.EpisodeModel>>.value(<_i21.EpisodeModel>[]))
          as _i7.Future<List<_i21.EpisodeModel>>);
  @override
  _i7.Future<List<_i20.TvShowModel>> getTvShowRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowRecommendations, [id]),
              returnValue:
                  Future<List<_i20.TvShowModel>>.value(<_i20.TvShowModel>[]))
          as _i7.Future<List<_i20.TvShowModel>>);
  @override
  _i7.Future<List<_i20.TvShowModel>> searchTvShows(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvShows, [query]),
              returnValue:
                  Future<List<_i20.TvShowModel>>.value(<_i20.TvShowModel>[]))
          as _i7.Future<List<_i20.TvShowModel>>);
}

/// A class which mocks [TvShowLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvShowLocalDataSource extends _i1.Mock
    implements _i22.TvShowLocalDataSource {
  MockTvShowLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<String> insertWatchlistTvShow(_i23.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlistTvShow, [tvShow]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<String> removeWatchlistTvShow(_i23.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistTvShow, [tvShow]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i23.TvShowTable?> getTvShowById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowById, [id]),
              returnValue: Future<_i23.TvShowTable?>.value())
          as _i7.Future<_i23.TvShowTable?>);
  @override
  _i7.Future<List<_i23.TvShowTable>> getWatchlistTvShows() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvShows, []),
              returnValue:
                  Future<List<_i23.TvShowTable>>.value(<_i23.TvShowTable>[]))
          as _i7.Future<List<_i23.TvShowTable>>);
  @override
  _i7.Future<void> cacheNowPlayingTvShows(List<_i23.TvShowTable>? tvShows) =>
      (super.noSuchMethod(Invocation.method(#cacheNowPlayingTvShows, [tvShows]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<List<_i23.TvShowTable>> getCachedNowPlayingTvShows() =>
      (super.noSuchMethod(Invocation.method(#getCachedNowPlayingTvShows, []),
              returnValue:
                  Future<List<_i23.TvShowTable>>.value(<_i23.TvShowTable>[]))
          as _i7.Future<List<_i23.TvShowTable>>);
  @override
  _i7.Future<void> cachePopularTvShows(List<_i23.TvShowTable>? tvShows) =>
      (super.noSuchMethod(Invocation.method(#cachePopularTvShows, [tvShows]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<List<_i23.TvShowTable>> getCachedPopularTvShows() =>
      (super.noSuchMethod(Invocation.method(#getCachedPopularTvShows, []),
              returnValue:
                  Future<List<_i23.TvShowTable>>.value(<_i23.TvShowTable>[]))
          as _i7.Future<List<_i23.TvShowTable>>);
  @override
  _i7.Future<void> cacheTopRatedTvShows(List<_i23.TvShowTable>? tvShows) =>
      (super.noSuchMethod(Invocation.method(#cacheTopRatedTvShows, [tvShows]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<List<_i23.TvShowTable>> getCachedTopRatedTvShows() =>
      (super.noSuchMethod(Invocation.method(#getCachedTopRatedTvShows, []),
              returnValue:
                  Future<List<_i23.TvShowTable>>.value(<_i23.TvShowTable>[]))
          as _i7.Future<List<_i23.TvShowTable>>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i24.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i25.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i26.Database?> get database =>
      (super.noSuchMethod(Invocation.getter(#database),
              returnValue: Future<_i26.Database?>.value())
          as _i7.Future<_i26.Database?>);
  @override
  _i7.Future<void> insertCacheTransactionMovies(
          List<_i14.MovieTable>? movies, String? category) =>
      (super.noSuchMethod(
          Invocation.method(#insertCacheTransactionMovies, [movies, category]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getCacheMovies(String? category) =>
      (super.noSuchMethod(Invocation.method(#getCacheMovies, [category]),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i7.Future<List<Map<String, dynamic>>>);
  @override
  _i7.Future<int> clearCacheMovies(String? category) =>
      (super.noSuchMethod(Invocation.method(#clearCacheMovies, [category]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> insertWatchlistMovie(_i14.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlistMovie, [movie]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> removeWatchlistMovie(_i14.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistMovie, [movie]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<Map<String, dynamic>?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i7.Future<Map<String, dynamic>?>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i7.Future<List<Map<String, dynamic>>>);
  @override
  _i7.Future<void> insertCacheTransactionTvShows(
          List<_i23.TvShowTable>? tvshows, String? category) =>
      (super.noSuchMethod(
          Invocation.method(
              #insertCacheTransactionTvShows, [tvshows, category]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getCacheTvShows(String? category) =>
      (super.noSuchMethod(Invocation.method(#getCacheTvShows, [category]),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i7.Future<List<Map<String, dynamic>>>);
  @override
  _i7.Future<int> clearCacheTvShows(String? category) =>
      (super.noSuchMethod(Invocation.method(#clearCacheTvShows, [category]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> insertWatchlistTvShow(_i23.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlistTvShow, [tvShow]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> removeWatchlistTvShow(_i23.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistTvShow, [tvShow]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<Map<String, dynamic>?> getTvShowById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i7.Future<Map<String, dynamic>?>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getWatchlistTvShows() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvShows, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i7.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i5.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i5.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i27.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i27.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i27.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i27.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i28.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i28.Uint8List>.value(_i28.Uint8List(0)))
          as _i7.Future<_i28.Uint8List>);
  @override
  _i7.Future<_i5.StreamedResponse> send(_i5.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue:
                  Future<_i5.StreamedResponse>.value(_FakeStreamedResponse_4()))
          as _i7.Future<_i5.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
}
