part of 'watchlist_bloc.dart';

abstract class WatchlistState extends Equatable {
  const WatchlistState();
  
  @override
  List<Object> get props => [];
}

class WatchlistEmpty extends WatchlistState {
  final String message;
 
  WatchlistEmpty(this.message);
 
  @override
  List<Object> get props => [message];
}
 
class WatchlistLoading extends WatchlistState {}
 
class WatchlistError extends WatchlistState {
  final String message;
 
  WatchlistError(this.message);
 
  @override
  List<Object> get props => [message];
}

class WatchlistHasData<T> extends WatchlistState {
  final List<T> WatchlistResult;
 
  WatchlistHasData(this.WatchlistResult);
 
  @override
  List<Object> get props => [WatchlistResult];
}

