import 'package:core/core.dart';
import 'package:core/presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tv_show/presentation/bloc/airing_today_tv_shows_bloc/airing_today_tv_shows_bloc.dart';

class AiringTodayTvShowsPage extends StatefulWidget {
  static const routeName = '/airing-today-tvshow';

  @override
  _AiringTodayTvShowsPageState createState() => _AiringTodayTvShowsPageState();
}

class _AiringTodayTvShowsPageState extends State<AiringTodayTvShowsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<AiringTodayTvShowsBloc>(context, listen: false)
            .add(AiringTodayTvShowsEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airing Today Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<AiringTodayTvShowsBloc, AiringTodayTvShowsState>(
          builder: (context, state) {
            if (state is AiringTodayTvShowsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AiringTodayTvShowsLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = state.tvShows[index];
                  return TvShowCard(tvShow);
                },
                itemCount: state.tvShows.length,
              );
            } else if (state is AiringTodayTvShowsEmpty) {
              return Center(
                child: Text('Empty Airing Today Tv Show', style: kSubtitle),
              );
            } else if (state is AiringTodayTvShowsError) {
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
