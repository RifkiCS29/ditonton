import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_show_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-page';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
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
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Watchlist'),
          bottom: TabBar(
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
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
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
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      );
  }
}
