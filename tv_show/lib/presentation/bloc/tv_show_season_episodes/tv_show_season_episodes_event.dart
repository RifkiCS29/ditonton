part of 'tv_show_season_episodes_bloc.dart';

class TvShowSeasonEpisodesEvent {
  final int id;
  final int seasonNumber;

  const TvShowSeasonEpisodesEvent({
    required this.id, 
    required this.seasonNumber
  });
}
