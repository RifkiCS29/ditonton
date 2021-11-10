import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status_movie.dart';
import 'package:watchlist/domain/usecases/remove_watchlist_movie.dart';
import 'package:watchlist/domain/usecases/save_watchlist_movie.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatusMovie getWatchListStatus;
  final SaveWatchlistMovie saveWatchlist;
  final RemoveWatchlistMovie removeWatchlist;

  bool _isAddedtoWatchlist = false;
  bool get isAddedtoWatchList => _isAddedtoWatchlist;
  
  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieDetailEmpty()) {
    on<FetchMovieDetail>((event, emit) async {
      emit(MovieDetailLoading());
      final detailResult = await getMovieDetail.execute(event.id);
      final recommendationResult = await getMovieRecommendations.execute(event.id);

      detailResult.fold(
        (failure) {
          emit(MovieDetailError(failure.message));
        },
        (movie) {
          emit(MovieRecommendationLoading());
          recommendationResult.fold(
            (failure) {
              emit(MovieRecommendationError(failure.message));
            },
            (movies) {
              emit(MovieDetailLoaded(movie, movies, _isAddedtoWatchlist));
            },
          );
        },
      );
    });
    on<AddToWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.movieDetail);
      
      await result.fold(
        (failure) async {
          emit(MovieDetailError(failure.message));
        },
        (successMessage) async {
          final result = await getWatchListStatus.execute(event.movieDetail.id);
          _isAddedtoWatchlist = result;
          emit(MovieAddedToWatchlist(successMessage));
        }
      );
    });
    on<RemoveFromWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.movieDetail);
      
      await result.fold(
        (failure) async {
          emit(MovieDetailError(failure.message));
        },
        (successMessage) async {
          final result = await getWatchListStatus.execute(event.movieDetail.id);
          _isAddedtoWatchlist = result;
          emit(MovieRemovedFromWatchlist(successMessage));
        }
      );
    });
    on<LoadWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      _isAddedtoWatchlist = result;
    });
  }
}
