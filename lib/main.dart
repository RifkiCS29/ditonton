import 'package:about/about_page.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_list_bloc/movie_list_bloc.dart';
import 'package:movie/presentation/bloc/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movies_bloc/top_rated_movies_bloc.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:tv_show/presentation/bloc/airing_today_tv_shows_bloc/airing_today_tv_shows_bloc.dart';
import 'package:tv_show/presentation/bloc/popular_tv_shows_bloc/popular_tv_shows_bloc.dart';
import 'package:tv_show/presentation/bloc/top_rated_tv_shows_bloc/top_rated_tv_shows_bloc.dart';
import 'package:tv_show/presentation/bloc/tv_show_list_bloc/tv_show_list_bloc.dart';
import 'package:watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:tv_show/presentation/pages/airing_today_tv_show_page.dart';
import 'package:core/presentation/pages/home_page.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:tv_show/presentation/pages/popular_tv_shows_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:tv_show/presentation/pages/top_rated_tv_shows_page.dart';
import 'package:tv_show/presentation/pages/tv_show_detail_page.dart';
import 'package:tv_show/presentation/pages/tv_show_season_episodes_page.dart';
import 'package:tv_show/presentation/provider/tv_show_detail_notifier.dart';
import 'package:tv_show/presentation/provider/tv_show_season_episodes_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:search/presentation/pages/search_page.dart';
import 'package:watchlist/presentation/pages/watchlist_page.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<NowPlayingMovieListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMovieListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMovieListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<AiringTodayTvShowListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvShowListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvShowListBloc>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvShowDetailNotifier>(),
        ),
        BlocProvider(
          create: (_) => di.locator<AiringTodayTvShowsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvShowsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvShowsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvShowsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTvShowBloc>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvShowSeasonEpisodesNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme, 
          colorScheme: kColorScheme.copyWith(secondary: kMikadoYellow),
        ),
        home: HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomePage());
            case PopularMoviesPage.routeName:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.routeName:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case AiringTodayTvShowsPage.routeName:
              return CupertinoPageRoute(builder: (_) => AiringTodayTvShowsPage());
            case PopularTvShowsPage.routeName:
              return CupertinoPageRoute(builder: (_) => PopularTvShowsPage());
            case TopRatedTvShowsPage.routeName:
              return CupertinoPageRoute(builder: (_) => TopRatedTvShowsPage());
            case TvShowDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvShowDetailPage(id: id),
                settings: settings,
              );
            case TvShowSeasonEpisodesPage.routeName:
              final args = settings.arguments as Map<String, dynamic>;
              final id = args['id'];
              final seasonNumber = args['seasonNumber'];
              return MaterialPageRoute(
                builder: (_) => TvShowSeasonEpisodesPage(
                    id: id,
                    seasonNumber: seasonNumber),
                settings: settings,
              );
            case SearchPage.routeName:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistPage.routeName:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case AboutPage.routeName:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
