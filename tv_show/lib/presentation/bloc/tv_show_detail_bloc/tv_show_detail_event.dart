part of 'tv_show_detail_bloc.dart';

abstract class TvShowDetailEvent extends Equatable {
  const TvShowDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchTvShowDetail extends TvShowDetailEvent {
  final int id;

  FetchTvShowDetail(this.id);

  @override
  List<Object> get props => [id];
}

class AddToWatchlist extends TvShowDetailEvent {
  final TvShowDetail tvShowDetail;

  AddToWatchlist(this.tvShowDetail);

  @override
  List<Object> get props => [tvShowDetail];
}

class RemoveFromWatchlist extends TvShowDetailEvent {
  final TvShowDetail tvShowDetail;

  RemoveFromWatchlist(this.tvShowDetail);

  @override
  List<Object> get props => [tvShowDetail];
}

class LoadWatchlistStatus extends TvShowDetailEvent {
  final int id;

  LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}