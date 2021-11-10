import 'package:bloc/bloc.dart';
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
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvShowDetail getTvShowDetail;
  final GetTvShowRecommendations getTvShowRecommendations;
  final GetWatchListStatusTvShow getWatchListStatus;
  final SaveWatchlistTvShow saveWatchlist;
  final RemoveWatchlistTvShow removeWatchlist;

  bool _isAddedtoWatchlist = false;
  bool get isAddedtoWatchList => _isAddedtoWatchlist;
  
  TvShowDetailBloc({
    required this.getTvShowDetail,
    required this.getTvShowRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(TvShowDetailEmpty()) {
    on<FetchTvShowDetail>((event, emit) async {
      emit(TvShowDetailLoading());
      final detailResult = await getTvShowDetail.execute(event.id);
      final recommendationResult = await getTvShowRecommendations.execute(event.id);

      detailResult.fold(
        (failure) {
          emit(TvShowDetailError(failure.message));
        },
        (tvShow) {
          emit(TvShowRecommendationLoading());
          recommendationResult.fold(
            (failure) {
              emit(TvShowRecommendationError(failure.message));
            },
            (tvShows) {
              emit(TvShowDetailLoaded(tvShow, tvShows, _isAddedtoWatchlist));
            },
          );
        },
      );
    });
    on<AddToWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.tvShowDetail);
      
      await result.fold(
        (failure) async {
          emit(TvShowDetailError(failure.message));
        },
        (successMessage) async {
          final result = await getWatchListStatus.execute(event.tvShowDetail.id);
          _isAddedtoWatchlist = result;
          emit(TvShowAddedToWatchlist(successMessage));
        }
      );
    });
    on<RemoveFromWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.tvShowDetail);
      
      await result.fold(
        (failure) async {
          emit(TvShowDetailError(failure.message));
        },
        (successMessage) async {
          final result = await getWatchListStatus.execute(event.tvShowDetail.id);
          _isAddedtoWatchlist = result;
          emit(TvShowRemovedFromWatchlist(successMessage));
        }
      );
    });
    on<LoadWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      _isAddedtoWatchlist = result;
    });
  }
}