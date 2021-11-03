import 'package:about/about_page.dart';
import 'package:core/core.dart';
import 'package:tv_show/presentation/pages/airing_today_tv_show_page.dart';
import 'package:core/presentation/pages/home_page.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:tv_show/presentation/pages/popular_tv_shows_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:tv_show/presentation/pages/top_rated_tv_shows_page.dart';
import 'package:tv_show/presentation/pages/tv_show_detail_page.dart';
import 'package:tv_show/presentation/pages/tv_show_season_episodes_page.dart';
import 'package:tv_show/presentation/provider/airing_today_tv_shows_notifier.dart';
import 'package:movie/presentation/provider/movie_detail_notifier.dart';
import 'package:movie/presentation/provider/movie_list_notifier.dart';
import 'package:movie/presentation/provider/popular_movies_notifier.dart';
import 'package:tv_show/presentation/provider/popular_tv_shows_notifier.dart';
import 'package:movie/presentation/provider/top_rated_movies_notifier.dart';
import 'package:tv_show/presentation/provider/top_rated_tv_shows_notifier.dart';
import 'package:tv_show/presentation/provider/tv_show_detail_notifier.dart';
import 'package:tv_show/presentation/provider/tv_show_list_notifier.dart';
import 'package:tv_show/presentation/provider/tv_show_season_episodes_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:search/presentation/pages/search_page.dart';
import 'package:search/presentation/provider/movie_search_notifier.dart';
import 'package:search/presentation/provider/tv_show_search_notifier.dart';
import 'package:watchlist/presentation/pages/watchlist_page.dart';
import 'package:watchlist/presentation/provider/watchlist_movie_notifier.dart';
import 'package:watchlist/presentation/provider/watchlist_tv_show_notifier.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvShowListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvShowDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<AiringTodayTvShowsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvShowsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvShowsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvShowNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvShowSearchNotifier>(),
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
