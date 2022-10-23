import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:equatable/equatable.dart';
import 'package:watchlist/domain/usecases/get_watchlist_movies.dart';
import 'package:watchlist/domain/usecases/get_watchlist_tv_shows.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistMoviesBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlistMovies _getWatchlistMovies;
  WatchlistMoviesBloc(this._getWatchlistMovies) : super(const WatchlistEmpty('')) {
    on<WatchlistEvent>((event, emit) async {
      emit(WatchlistLoading());
      final result = await _getWatchlistMovies.execute();
      result.fold(
        (failure) => emit(WatchlistError(failure.message)),
        (moviesData) { 
          emit(WatchlistHasData<Movie>(moviesData));
          if(moviesData.isEmpty) {
            emit(const WatchlistEmpty("You haven't added a watch list"));
          }
        }
      );
    });
  }
}

class WatchlistTvShowsBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlistTvShows _getWatchlistTvShows;
  WatchlistTvShowsBloc(this._getWatchlistTvShows) : super(const WatchlistEmpty('')) {
    on<WatchlistEvent>((event, emit) async {
      emit(WatchlistLoading());
      final result = await _getWatchlistTvShows.execute();
      result.fold(
        (failure) => emit(WatchlistError(failure.message)),
        (tvShowsData) { 
          emit(WatchlistHasData<TvShow>(tvShowsData));
          if(tvShowsData.isEmpty) {
            emit(const WatchlistEmpty("You haven't added a watch list"));
          }
        }
      );
    });
  }
}
