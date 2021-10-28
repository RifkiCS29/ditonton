import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/tv_show_detail_model.dart';
import 'package:ditonton/data/models/tv_show_model.dart';
import 'package:ditonton/data/repositories/tv_show_repository_impl.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvShowRepositoryImpl repository;
  late MockTvShowRemoteDataSource mockRemoteDataSource;
  late MockTvShowLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockTvShowRemoteDataSource();
    mockLocalDataSource = MockTvShowLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TvShowRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tTvShowModel = TvShowModel(
      backdropPath: '/qw3J9cNeLioOLoR68WX7z79aCdK.jpg',
      firstAirDate: '2021-09-17',
      genreIds: [10759, 9648, 18],
      id: 93405,
      name: 'Squid Game',
      originalName: '오징어 게임',
      overview:
          'Hundreds of cash-strapped players accept a strange invitation to compete in children\'s games—with high stakes. But, a tempting prize awaits the victor.',
      popularity: 3686.872,
      posterPath: '/dDlEmu3EZ0Pgg93K2SVNLCjCSvE.jpg',
      voteAverage: 7.8,
      voteCount: 8271
  );

  final tTvShow = TvShow(
      backdropPath: '/qw3J9cNeLioOLoR68WX7z79aCdK.jpg',
      firstAirDate: '2021-09-17',
      genreIds: [10759, 9648, 18],
      id: 93405,
      name: 'Squid Game',
      originalName: '오징어 게임',
      overview:
          'Hundreds of cash-strapped players accept a strange invitation to compete in children\'s games—with high stakes. But, a tempting prize awaits the victor.',
      popularity: 3686.872,
      posterPath: '/dDlEmu3EZ0Pgg93K2SVNLCjCSvE.jpg',
      voteAverage: 7.8,
      voteCount: 8271
  );

  final tTvShowModelList = <TvShowModel>[tTvShowModel];
  final tTvShowList = <TvShow>[tTvShow];

  group('Now Playing Tv Shows', () {
    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getAiringTodayTvShows())
        .thenAnswer((_) async => []);
      //act 
      await repository.getAiringTodayTvShows();
      //assert
       verify(mockNetworkInfo.isConnected);
    });

    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getAiringTodayTvShows())
            .thenAnswer((_) async => tTvShowModelList);
        // act
        final result = await repository.getAiringTodayTvShows();
        // assert
        verify(mockRemoteDataSource.getAiringTodayTvShows());
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvShowList);
      });

      test(
      'should cache data locally when the call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getAiringTodayTvShows())
            .thenAnswer((_) async => tTvShowModelList);
        // act
        await repository.getAiringTodayTvShows();
        // assert
        verify(mockRemoteDataSource.getAiringTodayTvShows());
        verify(mockLocalDataSource.cacheNowPlayingTvShows([testTvShowCache]));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getAiringTodayTvShows())
            .thenThrow(ServerException());
        // act
        final result = await repository.getAiringTodayTvShows();
        // assert
        verify(mockRemoteDataSource.getAiringTodayTvShows());
        expect(result, equals(Left(ServerFailure(''))));
      });
    });
    
    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
          'should return cached data when device is offline',
          () async {
        // arrange
        when(mockLocalDataSource.getCachedNowPlayingTvShows())
          .thenAnswer((_) async => [testTvShowCache]);
        //act
        final result = await repository.getAiringTodayTvShows();
        //assert
        verify(mockLocalDataSource.getCachedNowPlayingTvShows());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testTvShowFromCache]);
      });

      test('should return CacheFailure when app has no cache', () async {
        // arrange
        when(mockLocalDataSource.getCachedNowPlayingTvShows())
            .thenThrow(CacheException('No Cache'));
        // act
        final result = await repository.getAiringTodayTvShows();
        // assert
        verify(mockLocalDataSource.getCachedNowPlayingTvShows());
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });

  group('Popular Tv Shows', () {
    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getPopularTvShows())
        .thenAnswer((_) async => []);
      //act 
      await repository.getPopularTvShows();
      //assert
       verify(mockNetworkInfo.isConnected);
    });

    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularTvShows())
            .thenAnswer((_) async => tTvShowModelList);
        // act
        final result = await repository.getPopularTvShows();
        // assert
        verify(mockRemoteDataSource.getPopularTvShows());
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvShowList);
      });

      test(
      'should cache data locally when the call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getPopularTvShows())
            .thenAnswer((_) async => tTvShowModelList);
        // act
        await repository.getPopularTvShows();
        // assert
        verify(mockRemoteDataSource.getPopularTvShows());
        verify(mockLocalDataSource.cachePopularTvShows([testTvShowCache]));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularTvShows())
            .thenThrow(ServerException());
        // act
        final result = await repository.getPopularTvShows();
        // assert
        verify(mockRemoteDataSource.getPopularTvShows());
        expect(result, equals(Left(ServerFailure(''))));
      });
    });
    
    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
          'should return cached data when device is offline',
          () async {
        // arrange
        when(mockLocalDataSource.getCachedPopularTvShows())
          .thenAnswer((_) async => [testTvShowCache]);
        //act
        final result = await repository.getPopularTvShows();
        //assert
        verify(mockLocalDataSource.getCachedPopularTvShows());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testTvShowFromCache]);
      });

      test('should return CacheFailure when app has no cache', () async {
        // arrange
        when(mockLocalDataSource.getCachedPopularTvShows())
            .thenThrow(CacheException('No Cache'));
        // act
        final result = await repository.getPopularTvShows();
        // assert
        verify(mockLocalDataSource.getCachedPopularTvShows());
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });

  group('Now Top Rated Tv Shows', () {
    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getTopRatedTvShows())
        .thenAnswer((_) async => []);
      //act 
      await repository.getTopRatedTvShows();
      //assert
       verify(mockNetworkInfo.isConnected);
    });

    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedTvShows())
            .thenAnswer((_) async => tTvShowModelList);
        // act
        final result = await repository.getTopRatedTvShows();
        // assert
        verify(mockRemoteDataSource.getTopRatedTvShows());
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvShowList);
      });

      test(
      'should cache data locally when the call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedTvShows())
            .thenAnswer((_) async => tTvShowModelList);
        // act
        await repository.getTopRatedTvShows();
        // assert
        verify(mockRemoteDataSource.getTopRatedTvShows());
        verify(mockLocalDataSource.cacheTopRatedTvShows([testTvShowCache]));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedTvShows())
            .thenThrow(ServerException());
        // act
        final result = await repository.getTopRatedTvShows();
        // assert
        verify(mockRemoteDataSource.getTopRatedTvShows());
        expect(result, equals(Left(ServerFailure(''))));
      });
    });
    
    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
          'should return cached data when device is offline',
          () async {
        // arrange
        when(mockLocalDataSource.getCachedTopRatedTvShows())
          .thenAnswer((_) async => [testTvShowCache]);
        //act
        final result = await repository.getTopRatedTvShows();
        //assert
        verify(mockLocalDataSource.getCachedTopRatedTvShows());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testTvShowFromCache]);
      });

      test('should return CacheFailure when app has no cache', () async {
        // arrange
        when(mockLocalDataSource.getCachedTopRatedTvShows())
            .thenThrow(CacheException('No Cache'));
        // act
        final result = await repository.getTopRatedTvShows();
        // assert
        verify(mockLocalDataSource.getCachedTopRatedTvShows());
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });

  group('Get Tv Show Detail', () {
    final tId = 1;
    final tTvShowResponse = TvShowDetailResponse(
      backdropPath: 'backdropPath',
      episodeRunTime: [1, 2],
      firstAirDate: "2021-10-31",
      genres: [
        GenreModel(
          id: 1, 
          name: 'Action'
        )
      ],
      homepage: "https://google.com",
      id: 1,
      inProduction: true,
      lastAirDate: "2021-10-31",
      name: 'name',
      numberOfEpisodes: 1,
      numberOfSeasons: 1,
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      seasons: [
        SeasonModel(
          airDate: '2012-02-27',
          episodeCount: 1,
          id: 1,
          name: 'name',
          overview: 'overview',
          posterPath: 'posterPath',
          seasonNumber: 1,
        ),
      ],
      status: 'status',
      tagline: 'tagline',
      type: 'type',
      voteAverage: 5.0,
      voteCount: 1,
    );

    test(
        'should return Tv Show data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowDetail(tId))
          .thenAnswer((_) async => tTvShowResponse);
      // act
      final result = await repository.getTvShowDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvShowDetail(tId));
      expect(result, equals(Right(testTvShowDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvShowDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvShowDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvShowDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvShowDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tv Show Season Episodes', () {
    final tEpisodeList = <EpisodeModel>[];
    final tId = 1;
    final tSeasonNumber = 1;

    test('should return episode list data when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowSeasonEpisodes(tId, tSeasonNumber))
          .thenAnswer((_) async => tEpisodeList);
      // act
      final result = await repository.getTvShowSeasonEpisodes(tId, tSeasonNumber);
      // assert
      verify(mockRemoteDataSource.getTvShowSeasonEpisodes(tId, tSeasonNumber));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tEpisodeList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowSeasonEpisodes(tId, tSeasonNumber))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvShowSeasonEpisodes(tId, tSeasonNumber);
      // assertbuild runner
      verify(mockRemoteDataSource.getTvShowSeasonEpisodes(tId, tSeasonNumber));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowSeasonEpisodes(tId, tSeasonNumber))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvShowSeasonEpisodes(tId, tSeasonNumber);
      // assert
      verify(mockRemoteDataSource.getTvShowSeasonEpisodes(tId, tSeasonNumber));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tv Show Recommendations', () {
    final tTvShowList = <TvShowModel>[];
    final tId = 1;

    test('should return data (Tv Show list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowRecommendations(tId))
          .thenAnswer((_) async => tTvShowList);
      // act
      final result = await repository.getTvShowRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvShowRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvShowList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvShowRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTvShowRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvShowRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvShowRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach Tv Shows', () {
    final tQuery = 'Game of Thrones';

    test('should return Tv Show list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvShows(tQuery))
          .thenAnswer((_) async => tTvShowModelList);
      // act
      final result = await repository.searchTvShows(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvShowList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvShows(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTvShows(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvShows(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTvShows(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlistTvShow(testTvShowTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlistTvShow(testTvShowDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlistTvShow(testTvShowTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlistTvShow(testTvShowDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlistTvShow(testTvShowTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlistTvShow(testTvShowDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlistTvShow(testTvShowTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlistTvShow(testTvShowDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getTvShowById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlistTvShow(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist Tv Shows', () {
    test('should return list of Tv Shows', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTvShows())
          .thenAnswer((_) async => [testTvShowTable]);
      // act
      final result = await repository.getWatchlistTvShows();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTvShow]);
    });
  });
}
