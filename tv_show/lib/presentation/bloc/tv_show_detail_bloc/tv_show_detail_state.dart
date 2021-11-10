part of 'tv_show_detail_bloc.dart';

abstract class TvShowDetailState extends Equatable {
  const TvShowDetailState();
  
  @override
  List<Object> get props => [];
}

class TvShowDetailEmpty extends TvShowDetailState {}

class TvShowDetailLoading extends TvShowDetailState {}

class TvShowRecommendationLoading extends TvShowDetailState {}

class TvShowDetailLoaded extends TvShowDetailState {
  final TvShowDetail tvShowDetail;
  final List<TvShow> tvShowRecommendations;
  final bool isAddedToWatchlist;

  TvShowDetailLoaded(
    this.tvShowDetail,
    this.tvShowRecommendations,
    this.isAddedToWatchlist,
  );

  @override
  List<Object> get props => [tvShowDetail, tvShowRecommendations, isAddedToWatchlist];
}

class TvShowDetailError extends TvShowDetailState {
  final String message;

  TvShowDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TvShowRecommendationError extends TvShowDetailState {
  final String message;

  TvShowRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class TvShowAddedToWatchlist extends TvShowDetailState {
  final String message;

  TvShowAddedToWatchlist(this.message);

  @override
  List<Object> get props => [message];
}

class TvShowRemovedFromWatchlist extends TvShowDetailState {
  final String message;

  TvShowRemovedFromWatchlist(this.message);

  @override
  List<Object> get props => [message];
}

