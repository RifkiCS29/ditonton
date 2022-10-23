import 'package:core/common/constants.dart';
import 'package:core/common/utils.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistPage extends StatefulWidget {
  static const routeName = '/watchlist-page';

  const WatchlistPage({Key? key}) : super(key: key);

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  final List<String> _tabTitle = ['Movies', 'Tv Shows'];
  final List<Widget> _bodyPage = [const _WatchlistMovies(), const _WatchlistTvShows()];

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistMoviesBloc>(context, listen: false)
            .add(WatchlistEvent()),);
    Future.microtask(() =>
        Provider.of<WatchlistTvShowsBloc>(context, listen: false)
            .add(WatchlistEvent()),);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistMoviesBloc>(context, listen: false)
      .add(WatchlistEvent());
    Provider.of<WatchlistTvShowsBloc>(context, listen: false)
      .add(WatchlistEvent());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watchlist'),
          bottom: TabBar(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50), // Creates border
              color: Colors.lightGreen[600],),
            tabs: [
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.movie),
                    const SizedBox(width: 8),
                    Text(_tabTitle[0], style: kSubtitle),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.tv),
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
        child: BlocBuilder<WatchlistMoviesBloc, WatchlistState>(
          builder: (context, state) {
            if (state is WatchlistLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistHasData<Movie>) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.WatchlistResult[index];
                  return MovieCard(movie);
                },
                itemCount: state.WatchlistResult.length,
              );
            } else if (state is WatchlistEmpty) {
              return Center(
                child: Text(state.message, style: kSubtitle),
              );
            } else if (state is WatchlistError) {
              return Center(
                child: Text(state.message, style: kSubtitle),
              );
            } else {
              return Container();
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
        child: BlocBuilder<WatchlistTvShowsBloc, WatchlistState>(
          builder: (context, state) {
            if (state is WatchlistLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistHasData<TvShow>) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = state.WatchlistResult[index];
                  return TvShowCard(tvShow);
                },
                itemCount: state.WatchlistResult.length,
              );
            } else if (state is WatchlistEmpty) {
              return Center(
                child: Text(state.message, style: kSubtitle),
              );
            } else if (state is WatchlistError) {
              return Center(
                child: Text(state.message, style: kSubtitle),
              );
            } else {
              return Container();
            }
          },
        ),
      );
  }
}
