import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:equatable/equatable.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tv_shows.dart';
import 'package:rxdart/src/transformers/backpressure/debounce.dart';
import 'package:rxdart/src/transformers/flat_map.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchMovieBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;
  SearchMovieBloc(this._searchMovies) : super(SearchEmpty('')) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;
      emit(SearchLoading());
      final result = await _searchMovies.execute(query);
      result.fold(
        (failure) => emit(SearchError(failure.message)),
        (moviesData) { 
          emit(SearchHasData<Movie>(moviesData));
          if(moviesData.isEmpty) {
            emit(SearchEmpty('No Result Found'));
          }
        }
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

class SearchTvShowBloc extends Bloc<SearchEvent, SearchState> {
  final SearchTvShows _searchTvShows;
  SearchTvShowBloc(this._searchTvShows) : super(SearchEmpty('')) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;
      emit(SearchLoading());
      final result = await _searchTvShows.execute(query);
      result.fold(
        (failure) => emit(SearchError(failure.message)),
        (tvShowsData) { 
          emit(SearchHasData<TvShow>(tvShowsData));
          if(tvShowsData.isEmpty) {
            emit(SearchEmpty('No Result Found'));
          }
        }
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

EventTransformer<MyEvent> debounce<MyEvent>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}