import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:core/common/network_info.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/tv_show_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_list_bloc/movie_list_bloc.dart';
import 'package:movie/presentation/bloc/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movies_bloc/top_rated_movies_bloc.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:tv_show/domain/usecases/get_airing_today_tv_shows.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:tv_show/domain/usecases/get_popular_tv_shows.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:tv_show/domain/usecases/get_top_rated_tv_shows.dart';
import 'package:tv_show/domain/usecases/get_tv_show_detail.dart';
import 'package:tv_show/domain/usecases/get_tv_show_recommendations.dart';
import 'package:tv_show/domain/usecases/get_tv_show_season_episodes.dart';
import 'package:tv_show/presentation/bloc/airing_today_tv_shows_bloc/airing_today_tv_shows_bloc.dart';
import 'package:tv_show/presentation/bloc/popular_tv_shows_bloc/popular_tv_shows_bloc.dart';
import 'package:tv_show/presentation/bloc/top_rated_tv_shows_bloc/top_rated_tv_shows_bloc.dart';
import 'package:tv_show/presentation/bloc/tv_show_list_bloc/tv_show_list_bloc.dart';
import 'package:tv_show/presentation/bloc/tv_show_season_episodes/tv_show_season_episodes_bloc.dart';
import 'package:watchlist/domain/usecases/get_watchlist_movies.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status_movie.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status_tv_show.dart';
import 'package:watchlist/domain/usecases/get_watchlist_tv_shows.dart';
import 'package:watchlist/domain/usecases/remove_watchlist_movie.dart';
import 'package:watchlist/domain/usecases/remove_watchlist_tv_show.dart';
import 'package:watchlist/domain/usecases/save_watchlist_movie.dart';
import 'package:watchlist/domain/usecases/save_watchlist_tv_show.dart';
import 'package:watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tv_shows.dart';
import 'package:tv_show/presentation/provider/tv_show_detail_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'package:core/data/datasources/tv_show_local_data_source.dart';
import 'package:core/data/repositories/tv_show_repository_impl.dart';
import 'package:core/domain/repositories/tv_show_repository.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => NowPlayingMovieListBloc(
      locator(),
    )
  );
  locator.registerFactory(
    () => TopRatedMovieListBloc(
      locator(),
    )
  );
  locator.registerFactory(
    () => PopularMovieListBloc(
      locator(),
    )
  );
  locator.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchMovieBloc(
      locator(),
    )
  );
  locator.registerFactory(
    () => PopularMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => AiringTodayTvShowListBloc(
      locator(),
    )
  );
  locator.registerFactory(
    () => TopRatedTvShowListBloc(
      locator(),
    )
  );
  locator.registerFactory(
    () => PopularTvShowListBloc(
      locator(),
    )
  );
  locator.registerFactory(
    () => TvShowDetailNotifier(
      getTvShowDetail: locator(),
      getTvShowRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchTvShowBloc(
      locator(),
    )
  );
  locator.registerFactory(
    () => AiringTodayTvShowsBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvShowsBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvShowsBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvShowsBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvShowSeasonEpisodesBloc(
      locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusMovie(locator()));
  locator.registerLazySingleton(() => SaveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetAiringTodayTvShows(locator()));
  locator.registerLazySingleton(() => GetPopularTvShows(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvShows(locator()));
  locator.registerLazySingleton(() => GetTvShowDetail(locator()));
  locator.registerLazySingleton(() => GetTvShowSeasonEpisodes(locator()));
  locator.registerLazySingleton(() => GetTvShowRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvShows(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTvShow(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvShow(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvShow(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvShows(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator()
    ),
  );

  locator.registerLazySingleton<TvShowRepository>(
    () => TvShowRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator()
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvShowRemoteDataSource>(
      () => TvShowRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvShowLocalDataSource>(
      () => TvShowLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DataConnectionChecker());
}
