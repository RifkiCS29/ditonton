part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  
  @override
  List<Object> get props => [];
}

class SearchEmpty extends SearchState {
  final String message;
 
  SearchEmpty(this.message);
 
  @override
  List<Object> get props => [message];
}
 
class SearchLoading extends SearchState {}
 
class SearchError extends SearchState {
  final String message;
 
  SearchError(this.message);
 
  @override
  List<Object> get props => [message];
}

class SearchHasData<T> extends SearchState {
  final List<T> searchResult;
 
  SearchHasData(this.searchResult);
 
  @override
  List<Object> get props => [searchResult];
}
