part of 'airing_today_tv_shows_bloc.dart';

abstract class AiringTodayTvShowsState extends Equatable {
  const AiringTodayTvShowsState();
  
  @override
  List<Object> get props => [];
}

class AiringTodayTvShowsEmpty extends AiringTodayTvShowsState {}

class AiringTodayTvShowsLoading extends AiringTodayTvShowsState {}

class AiringTodayTvShowsLoaded extends AiringTodayTvShowsState {
  final List<TvShow> tvShows;

  AiringTodayTvShowsLoaded(this.tvShows);

  @override
  List<Object> get props => [tvShows];
}

class AiringTodayTvShowsError extends AiringTodayTvShowsState {
  final String message;

  AiringTodayTvShowsError(this.message);

  @override
  List<Object> get props => [message];
}
