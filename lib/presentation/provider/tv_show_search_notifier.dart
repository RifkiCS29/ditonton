import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/search_tv_shows.dart';
import 'package:flutter/foundation.dart';

class TvShowSearchNotifier extends ChangeNotifier {
  final SearchTvShows searchTvShows;

  TvShowSearchNotifier({required this.searchTvShows});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvShow> _searchResult = [];
  List<TvShow> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvShowSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvShows.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvShowsData) {
        _searchResult = tvShowsData;
        _state = RequestState.Loaded;
        notifyListeners();

        if(tvShowsData.isEmpty) {
          _state = RequestState.Empty;
          notifyListeners();
          return _message = 'No Result Found';
        }
      },
    );
  }
}
