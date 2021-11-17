part of 'tv_show_detail_bloc.dart';

class TvShowDetailState extends Equatable {
  final TvShowDetail? tvShowDetail;
  final List<TvShow> tvShowRecommendations;
  final RequestState tvShowDetailState;
  final RequestState tvShowRecommendationState;
  final String message;
  final String watchlistMessage;
  final bool isAddedToWatchlist;

  TvShowDetailState({
    required this.tvShowDetail,
    required this.tvShowRecommendations,
    required this.tvShowDetailState,
    required this.tvShowRecommendationState,
    required this.message,
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
  });

  TvShowDetailState copyWith({
    TvShowDetail? tvShowDetail,
    List<TvShow>? tvShowRecommendations,
    RequestState? tvShowDetailState,
    RequestState? tvShowRecommendationState,
    String? message,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
  }) {
    return TvShowDetailState(
      tvShowDetail: tvShowDetail ?? this.tvShowDetail,
      tvShowRecommendations: tvShowRecommendations ?? this.tvShowRecommendations,
      tvShowDetailState: tvShowDetailState ?? this.tvShowDetailState,
      tvShowRecommendationState: tvShowRecommendationState ?? this.tvShowRecommendationState,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }

  factory TvShowDetailState.initial() {
    return TvShowDetailState(
      tvShowDetail: null,
      tvShowRecommendations: [],
      tvShowDetailState: RequestState.Empty,
      tvShowRecommendationState: RequestState.Empty,
      message: '',
      watchlistMessage: '',
      isAddedToWatchlist: false,
    );
  }

  @override
  List<Object?> get props => [
    tvShowDetail,
    tvShowRecommendations,
    tvShowDetailState,
    tvShowRecommendationState,
    message,
    watchlistMessage,
    isAddedToWatchlist,
  ];
}

