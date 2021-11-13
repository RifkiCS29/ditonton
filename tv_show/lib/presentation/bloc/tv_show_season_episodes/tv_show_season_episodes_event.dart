part of 'tv_show_season_episodes_bloc.dart';

abstract class TvShowSeasonEpisodesEvent extends Equatable {
  const TvShowSeasonEpisodesEvent();

  @override
  List<Object> get props => [];
}

class FetchTvShowSeasonEpisodesEvent extends TvShowSeasonEpisodesEvent {
  final int id;
  final int seasonNumber;

  FetchTvShowSeasonEpisodesEvent(this.id, this.seasonNumber);

  @override
  List<Object> get props => [id, seasonNumber];
}