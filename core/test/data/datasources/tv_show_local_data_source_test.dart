import 'package:core/common/exception.dart';
import 'package:core/data/datasources/tv_show_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvShowLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TvShowLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistTvShow(testTvShowTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlistTvShow(testTvShowTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistTvShow(testTvShowTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlistTvShow(testTvShowTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistTvShow(testTvShowTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlistTvShow(testTvShowTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistTvShow(testTvShowTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlistTvShow(testTvShowTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Tv Show Detail By Id', () {
    const tId = 1;

    test('should return Tv Show Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getTvShowById(tId))
          .thenAnswer((_) async => testTvShowMap);
      // act
      final result = await dataSource.getTvShowById(tId);
      // assert
      expect(result, testTvShowTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTvShowById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTvShowById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist Tv Shows', () {
    test('should return list of TvShowTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvShows())
          .thenAnswer((_) async => [testTvShowMap]);
      // act
      final result = await dataSource.getWatchlistTvShows();
      // assert
      expect(result, [testTvShowTable]);
    });
  });

  group('cache now playing Tv Shows', () {
    test('should call database helper to save data', () async {
      // arrange
      when(mockDatabaseHelper.clearCacheTvShows('now playing'))
          .thenAnswer((_) async => 1);
      // act
      await dataSource.cacheNowPlayingTvShows([testTvShowCache]);
      // assert
      verify(mockDatabaseHelper.clearCacheTvShows('now playing'));
      verify(mockDatabaseHelper
          .insertCacheTransactionTvShows([testTvShowCache], 'now playing'),);
    });

    test('should return list of Tv Shows from db when data exist', () async {
      // arrange
      when(mockDatabaseHelper.getCacheTvShows('now playing'))
          .thenAnswer((_) async => [testTvShowCacheMap]);
      // act
      final result = await dataSource.getCachedNowPlayingTvShows();
      // assert
      expect(result, [testTvShowCache]);
    });

    test('should throw CacheException when cache data is not exist', () async {
      // arrange
      when(mockDatabaseHelper.getCacheTvShows('now playing'))
          .thenAnswer((_) async => []);
      // act
      final call = dataSource.getCachedNowPlayingTvShows();
      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });

  group('cache popular Tv Shows', () {
    test('should call database helper to save data', () async {
      // arrange
      when(mockDatabaseHelper.clearCacheTvShows('popular'))
          .thenAnswer((_) async => 1);
      // act
      await dataSource.cachePopularTvShows([testTvShowCache]);
      // assert
      verify(mockDatabaseHelper.clearCacheTvShows('popular'));
      verify(mockDatabaseHelper
          .insertCacheTransactionTvShows([testTvShowCache], 'popular'),);
    });

    test('should return list of Tv Shows from db when data exist', () async {
      // arrange
      when(mockDatabaseHelper.getCacheTvShows('popular'))
          .thenAnswer((_) async => [testTvShowCacheMap]);
      // act
      final result = await dataSource.getCachedPopularTvShows();
      // assert
      expect(result, [testTvShowCache]);
    });

    test('should throw CacheException when cache data is not exist', () async {
      // arrange
      when(mockDatabaseHelper.getCacheTvShows('popular'))
          .thenAnswer((_) async => []);
      // act
      final call = dataSource.getCachedPopularTvShows();
      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });

  
  group('cache top rated Tv Shows', () {
    test('should call database helper to save data', () async {
      // arrange
      when(mockDatabaseHelper.clearCacheTvShows('top rated'))
          .thenAnswer((_) async => 1);
      // act
      await dataSource.cacheTopRatedTvShows([testTvShowCache]);
      // assert
      verify(mockDatabaseHelper.clearCacheTvShows('top rated'));
      verify(mockDatabaseHelper
          .insertCacheTransactionTvShows([testTvShowCache], 'top rated'),);
    });

    test('should return list of TvShows from db when data exist', () async {
      // arrange
      when(mockDatabaseHelper.getCacheTvShows('top rated'))
          .thenAnswer((_) async => [testTvShowCacheMap]);
      // act
      final result = await dataSource.getCachedTopRatedTvShows();
      // assert
      expect(result, [testTvShowCache]);
    });

    test('should throw CacheException when cache data is not exist', () async {
      // arrange
      when(mockDatabaseHelper.getCacheTvShows('top rated'))
          .thenAnswer((_) async => []);
      // act
      final call = dataSource.getCachedTopRatedTvShows();
      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });
}


