part of 'movie_list_bloc.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();
  
  @override
  List<Object> get props => [];
}

class MovieListEmpty extends MovieListState {}

class MovieListLoading extends MovieListState {}

class MovieListLoaded extends MovieListState {
  final List<Movie> movies;

  MovieListLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class MovieListError extends MovieListState {
  final String message;

  MovieListError(this.message);

  @override
  List<Object> get props => [message];
}
