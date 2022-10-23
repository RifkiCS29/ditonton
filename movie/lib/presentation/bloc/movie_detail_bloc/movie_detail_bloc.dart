import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
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
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatusMovie getWatchListStatus;
  final SaveWatchlistMovie saveWatchlist;
  final RemoveWatchlistMovie removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  
  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieDetailState.initial()) {
    on<FetchMovieDetail>((event, emit) async {
      emit(state.copyWith(movieDetailState: RequestState.Loading));
      final detailResult = await getMovieDetail.execute(event.id);
      final recommendationResult = await getMovieRecommendations.execute(event.id);

      detailResult.fold(
        (failure) async {
          emit(
            state.copyWith(
              movieDetailState: RequestState.Error, 
              message: failure.message,
            ),
          );
        },
        (movie) async {
          emit(
            state.copyWith(
              movieRecommendationState: RequestState.Loading,
              movieDetail: movie,
              movieDetailState: RequestState.Loaded,
              message: '',
            ),
          );
          recommendationResult.fold(
            (failure) {
              emit(            
                state.copyWith(
                  movieRecommendationState: RequestState.Error, 
                  message: failure.message,
                ),
              );
            },
            (movies) {
              emit(
                state.copyWith(
                  movieRecommendationState: RequestState.Loaded,
                  movieRecommendations: movies,
                  message: '',
                ),
              );
            },
          );
        },
      );
    });
    on<AddToWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.movieDetail);
      
      result.fold(
        (failure) {
          emit(state.copyWith(watchlistMessage: failure.message));
        },
        (successMessage) {
          emit(state.copyWith(watchlistMessage: successMessage));
        }
      );

      add(LoadWatchlistStatus(event.movieDetail.id));

    });
    on<RemoveFromWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.movieDetail);
      
      result.fold(
        (failure) {
          emit(state.copyWith(watchlistMessage: failure.message));
        },
        (successMessage) {
          emit(state.copyWith(watchlistMessage: successMessage));
        }
      );

      add(LoadWatchlistStatus(event.movieDetail.id));

    });
    on<LoadWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: result));
    });
  }
}