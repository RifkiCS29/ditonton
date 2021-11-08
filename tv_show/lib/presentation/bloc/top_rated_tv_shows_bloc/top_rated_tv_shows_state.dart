part of 'top_rated_tv_shows_bloc.dart';

abstract class TopRatedTvShowsState extends Equatable {
  const TopRatedTvShowsState();
  
  @override
  List<Object> get props => [];
}

class TopRatedTvShowsEmpty extends TopRatedTvShowsState {}

class TopRatedTvShowsLoading extends TopRatedTvShowsState {}

class TopRatedTvShowsLoaded extends TopRatedTvShowsState {
  final List<TvShow> tvShows;

  TopRatedTvShowsLoaded(this.tvShows);

  @override
  List<Object> get props => [tvShows];
}

class TopRatedTvShowsError extends TopRatedTvShowsState {
  final String message;

  TopRatedTvShowsError(this.message);

  @override
  List<Object> get props => [message];
}

