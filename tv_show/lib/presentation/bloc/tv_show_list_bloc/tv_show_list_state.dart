part of 'tv_show_list_bloc.dart';

abstract class TvShowListState extends Equatable {
  const TvShowListState();
  
  @override
  List<Object> get props => [];
}

class TvShowListEmpty extends TvShowListState {}

class TvShowListLoading extends TvShowListState {}

class TvShowListLoaded extends TvShowListState {
  final List<TvShow> tvShows;

  TvShowListLoaded(this.tvShows);

  @override
  List<Object> get props => [tvShows];
}

class TvShowListError extends TvShowListState {
  final String message;

  TvShowListError(this.message);

  @override
  List<Object> get props => [message];
}
