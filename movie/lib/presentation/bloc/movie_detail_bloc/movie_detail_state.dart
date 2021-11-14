part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();
  
  @override
  List<Object> get props => [];
}

class MovieDetailEmpty extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieRecommendationLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movieDetail;
  final List<Movie> movieRecommendations;
  final bool isAddedToWatchlist;

  MovieDetailLoaded(
    this.movieDetail,
    this.movieRecommendations,
    this.isAddedToWatchlist,
  );

  @override
  List<Object> get props => [movieDetail, movieRecommendations, isAddedToWatchlist];
}

class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieRecommendationError extends MovieDetailState {
  final String message;

  MovieRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class SuccessAddOrRemoveMovieToWatchlist extends MovieDetailState {
  final String message;

  SuccessAddOrRemoveMovieToWatchlist(this.message);

  @override
  List<Object> get props => [message];
}

class FailedAddOrRemoveMovieToWatchlist extends MovieDetailState {
  final String message;

  FailedAddOrRemoveMovieToWatchlist(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistStatus extends MovieDetailState {
  final bool result;

  MovieWatchlistStatus(this.result);

  @override
  List<Object> get props => [result];
}
