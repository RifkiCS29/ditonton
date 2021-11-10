part of 'tv_show_season_episodes_bloc.dart';

abstract class TvShowSeasonEpisodesState extends Equatable {
  const TvShowSeasonEpisodesState();
  
  @override
  List<Object> get props => [];
}

class TvShowSeasonEpisodesEmpty extends TvShowSeasonEpisodesState {}

class TvShowSeasonEpisodesLoading extends TvShowSeasonEpisodesState {}

class TvShowSeasonEpisodesLoaded extends TvShowSeasonEpisodesState {
  final List<Episode> episodes;

  TvShowSeasonEpisodesLoaded(this.episodes);

  @override
  List<Object> get props => [episodes];
} 

class TvShowSeasonEpisodesError extends TvShowSeasonEpisodesState {
  final String message;

  TvShowSeasonEpisodesError(this.message);

  @override
  List<Object> get props => [message];
}
