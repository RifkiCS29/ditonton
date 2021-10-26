import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_show_season_episodes_notifier.dart';
import 'package:ditonton/presentation/widgets/episode_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvShowSeasonEpisodesPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-show-season-episodes-page';
  final int id;
  final int seasonNumber;
  
  const TvShowSeasonEpisodesPage(
    { 
      Key? key, 
      required this.id, 
      required this.seasonNumber 
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
        Provider.of<TvShowSeasonEpisodesNotifier>(context, listen: false)
            .fetchTvShowSeasonEpisodes(widget.id, widget.seasonNumber));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Season ${widget.seasonNumber}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvShowSeasonEpisodesNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final episode = data.episode[index];
                  return EpisodeCard(episode);
                },
                itemCount: data.episode.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}