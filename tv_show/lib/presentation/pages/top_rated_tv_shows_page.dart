import 'package:core/core.dart';
import 'package:core/presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tv_show/presentation/bloc/top_rated_tv_shows_bloc/top_rated_tv_shows_bloc.dart';

class TopRatedTvShowsPage extends StatefulWidget {
  static const routeName = '/top-rated-tvshow';

  @override
  _TopRatedTvShowsPageState createState() => _TopRatedTvShowsPageState();
}

class _TopRatedTvShowsPageState extends State<TopRatedTvShowsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TopRatedTvShowsBloc>(context, listen: false)
            .add(TopRatedTvShowsEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvShowsBloc, TopRatedTvShowsState>(
          builder: (context, state) {
            if (state is TopRatedTvShowsEmpty) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTvShowsLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = state.tvShows[index];
                  return TvShowCard(tvShow);
                },
                itemCount: state.tvShows.length,
              );
            } else if (state is TopRatedTvShowsEmpty) {
              return Center(
                child: Text('Empty Top Rated TvShow', style: kSubtitle),
              );
            } else if (state is TopRatedTvShowsError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message, style: kSubtitle),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
