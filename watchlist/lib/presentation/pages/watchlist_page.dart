import 'package:core/common/constants.dart';
import 'package:core/common/state_enum.dart';
import 'package:core/common/utils.dart';
import 'package:watchlist/presentation/provider/watchlist_movie_notifier.dart';
import 'package:watchlist/presentation/provider/watchlist_tv_show_notifier.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistPage extends StatefulWidget {
  static const routeName = '/watchlist-page';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  final List<String> _tabTitle = ['Movies', 'Tv Shows'];
  final List<Widget> _bodyPage = [_WatchlistMovies(), _WatchlistTvShows()];

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistMovieNotifier>(context, listen: false)
            .fetchWatchlistMovies());
    Future.microtask(() =>
        Provider.of<WatchlistTvShowNotifier>(context, listen: false)
            .fetchWatchlistTvShows());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchlistTvShowNotifier>(context, listen: false)
        .fetchWatchlistTvShows();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Watchlist'),
          bottom: TabBar(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50), // Creates border
              color: Colors.lightGreen[600]),
            tabs: [
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.movie),
                    const SizedBox(width: 8),
                    Text(_tabTitle[0], style: kSubtitle),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.tv),
                    const SizedBox(width: 8),
                    Text(_tabTitle[1], style: kSubtitle),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(children: _bodyPage),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}

class _WatchlistMovies extends StatelessWidget {
  const _WatchlistMovies({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<WatchlistMovieNotifier>(
          builder: (context, data, child) {
            if (data.watchlistState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.watchlistState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data.watchlistMovies[index];
                  return MovieCard(movie);
                },
                itemCount: data.watchlistMovies.length,
              );
            } else if (data.watchlistState == RequestState.Empty) {
              return Center(
                child: Text(data.message, style: kSubtitle),
              );
            } else if (data.watchlistState == RequestState.Error) {
              return Center(
                child: Text(data.message, style: kSubtitle),
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message, style: kSubtitle),
              );
            }
          },
        ),
      );
  }
}

class _WatchlistTvShows extends StatelessWidget {
  const _WatchlistTvShows({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<WatchlistTvShowNotifier>(
          builder: (context, data, child) {
            if (data.watchlistState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.watchlistState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = data.watchlistTvShows[index];
                  return TvShowCard(tvShow);
                },
                itemCount: data.watchlistTvShows.length,
              );
            } else if (data.watchlistState == RequestState.Empty) {
              return Center(
                child: Text(data.message, style: kSubtitle),
              );
            } else if (data.watchlistState == RequestState.Error) {
              return Center(
                child: Text(data.message, style: kSubtitle),
              );
            }  else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message, style: kSubtitle),
              );
            }
          },
        ),
      );
  }
}