import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/presentation/bloc/tv_show_season_episodes/tv_show_season_episodes_bloc.dart';
import 'package:core/presentation/widgets/episode_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvShowSeasonEpisodesPage extends StatefulWidget {
  static const routeName = '/tv-show-season-episodes-page';
  final int id;
  final int seasonNumber;
  
  const TvShowSeasonEpisodesPage(
    { 
      Key? key, 
      required this.id, 
      required this.seasonNumber, 
    }
  ) : super(key: key);

  @override
  _TvShowSeasonEpisodesPageState createState() => _TvShowSeasonEpisodesPageState();
}

class _TvShowSeasonEpisodesPageState extends State<TvShowSeasonEpisodesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TvShowSeasonEpisodesBloc>(context, listen: false)
            .add(FetchTvShowSeasonEpisodesEvent(widget.id, widget.seasonNumber)),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Season ${widget.seasonNumber}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvShowSeasonEpisodesBloc, TvShowSeasonEpisodesState>(
          builder: (context, state) {
            if (state is TvShowSeasonEpisodesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvShowSeasonEpisodesLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final episode = state.episodes[index];
                  return EpisodeCard(episode);
                },
                itemCount: state.episodes.length,
              );
            } else if (state is TvShowSeasonEpisodesEmpty) {
              return Center(
                child: Text('Empty Episode', style: kSubtitle),
              );
            } else if (state is TvShowSeasonEpisodesError) {
              return Center(
                key: const Key('error_message'),
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