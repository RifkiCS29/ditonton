import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/entities/tv_show_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_show/domain/usecases/get_tv_show_detail.dart';
import 'package:tv_show/domain/usecases/get_tv_show_recommendations.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status_tv_show.dart';
import 'package:watchlist/domain/usecases/remove_watchlist_tv_show.dart';
import 'package:watchlist/domain/usecases/save_watchlist_tv_show.dart';

part 'tv_show_detail_event.dart';
part 'tv_show_detail_state.dart';

class TvShowDetailBloc extends Bloc<TvShowDetailEvent, TvShowDetailState> {
  final GetTvShowDetail getTvShowDetail;
  final GetTvShowRecommendations getTvShowRecommendations;
  final GetWatchListStatusTvShow getWatchListStatus;
  final SaveWatchlistTvShow saveWatchlist;
  final RemoveWatchlistTvShow removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  
  TvShowDetailBloc({
    required this.getTvShowDetail,
    required this.getTvShowRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(TvShowDetailState.initial()) {
    on<FetchTvShowDetail>((event, emit) async {
      emit(state.copyWith(tvShowDetailState: RequestState.Loading));
      final detailResult = await getTvShowDetail.execute(event.id);
      final recommendationResult = await getTvShowRecommendations.execute(event.id);

      detailResult.fold(
        (failure) async {
          emit(
            state.copyWith(
              tvShowDetailState: RequestState.Error, 
              message: failure.message
            )
          );
        },
        (tvShow) async {
          emit(
            state.copyWith(
              tvShowRecommendationState: RequestState.Loading,
              tvShowDetail: tvShow,
              tvShowDetailState: RequestState.Loaded,
              message: '',
            )
          );
          recommendationResult.fold(
            (failure) {
              emit(            
                state.copyWith(
                  tvShowRecommendationState: RequestState.Error, 
                  message: failure.message
                )
              );
            },
            (tvShows) {
              emit(
                state.copyWith(
                  tvShowRecommendationState: RequestState.Loaded,
                  tvShowRecommendations: tvShows,
                  message: '',
                )
              );
            },
          );
        },
      );
    });
    on<AddToWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.tvShowDetail);
      
      result.fold(
        (failure) {
          emit(state.copyWith(watchlistMessage: failure.message));
        },
        (successMessage) {
          emit(state.copyWith(watchlistMessage: successMessage));
        }
      );

      add(LoadWatchlistStatus(event.tvShowDetail.id));

    });
    on<RemoveFromWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.tvShowDetail);
      
      result.fold(
        (failure) {
          emit(state.copyWith(watchlistMessage: failure.message));
        },
        (successMessage) {
          emit(state.copyWith(watchlistMessage: successMessage));
        }
      );

      add(LoadWatchlistStatus(event.tvShowDetail.id));

    });
    on<LoadWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: result));
    });
  }
}