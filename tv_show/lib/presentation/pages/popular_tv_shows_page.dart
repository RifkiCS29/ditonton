import 'package:core/core.dart';
import 'package:core/presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tv_show/presentation/bloc/popular_tv_shows_bloc/popular_tv_shows_bloc.dart';

class PopularTvShowsPage extends StatefulWidget {
  static const routeName = '/popular-tvshow';

  @override
  _PopularTvShowsPageState createState() => _PopularTvShowsPageState();
}

class _PopularTvShowsPageState extends State<PopularTvShowsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PopularTvShowsBloc>(context, listen: false)
            .add(PopularTvShowsEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvShowsBloc, PopularTvShowsState>(
          builder: (context, state) {
            if (state is PopularTvShowsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvShowsLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = state.tvShows[index];
                  return TvShowCard(tvShow);
                },
                itemCount: state.tvShows.length,
              );
            } else if (state is PopularTvShowsEmpty) {
              return Center(
                child: Text('Empty Popular Tv Show', style: kSubtitle),
              );
            } else if (state is PopularTvShowsError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
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
