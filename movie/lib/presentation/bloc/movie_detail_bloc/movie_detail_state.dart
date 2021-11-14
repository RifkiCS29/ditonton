part of 'movie_detail_bloc.dart';

// abstract class MovieDetailState extends Equatable {
//   const MovieDetailState();
  
//   @override
//   List<Object> get props => [];
// }

// class MovieDetailEmpty extends MovieDetailState {}

// class MovieDetailLoading extends MovieDetailState {}

// class MovieRecommendationLoading extends MovieDetailState {}

// class MovieDetailLoaded extends MovieDetailState {
//   final MovieDetail movieDetail;
//   final List<Movie> movieRecommendations;
//   final bool isAddedToWatchlist;

//   MovieDetailLoaded(
//     this.movieDetail,
//     this.movieRecommendations,
//     this.isAddedToWatchlist,
//   );

//   @override
//   List<Object> get props => [movieDetail, movieRecommendations, isAddedToWatchlist];
// }

// class MovieDetailError extends MovieDetailState {
//   final String message;

//   MovieDetailError(this.message);

//   @override
//   List<Object> get props => [message];
// }

// class MovieRecommendationError extends MovieDetailState {
//   final String message;

//   MovieRecommendationError(this.message);

//   @override
//   List<Object> get props => [message];
// }

// class SuccessAddOrRemoveMovieToWatchlist extends MovieDetailState {
//   final String message;

//   SuccessAddOrRemoveMovieToWatchlist(this.message);

//   @override
//   List<Object> get props => [message];
// }

// class FailedAddOrRemoveMovieToWatchlist extends MovieDetailState {
//   final String message;

//   FailedAddOrRemoveMovieToWatchlist(this.message);

//   @override
//   List<Object> get props => [message];
// }

// class MovieWatchlistStatus extends MovieDetailState {
//   final bool result;

//   MovieWatchlistStatus(this.result);

//   @override
//   List<Object> get props => [result];
// }

class MovieDetailState {
  final MovieDetail? movieDetail;
  final List<Movie> movieRecommendations;
  final RequestState movieDetailState;
  final RequestState movieRecommendationState;
  final String message;
  final String watchlistMessage;
  final bool isAddedToWatchlist;

  MovieDetailState({
    required this.movieDetail,
    required this.movieRecommendations,
    required this.movieDetailState,
    required this.movieRecommendationState,
    required this.message,
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
  });

  MovieDetailState copyWith({
    MovieDetail? movieDetail,
    List<Movie>? movieRecommendations,
    RequestState? movieDetailState,
    RequestState? movieRecommendationState,
    String? message,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
  }) {
    return MovieDetailState(
      movieDetail: movieDetail ?? this.movieDetail,
      movieRecommendations: movieRecommendations ?? this.movieRecommendations,
      movieDetailState: movieDetailState ?? this.movieDetailState,
      movieRecommendationState: movieRecommendationState ?? this.movieRecommendationState,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }

  factory MovieDetailState.initial() {
    return MovieDetailState(
      movieDetail: null,
      movieRecommendations: [],
      movieDetailState: RequestState.Empty,
      movieRecommendationState: RequestState.Empty,
      message: '',
      watchlistMessage: '',
      isAddedToWatchlist: false,
    );
  }
}
