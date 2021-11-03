import 'package:core/common/state_enum.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:tv_show/domain/usecases/get_airing_today_tv_shows.dart';
import 'package:flutter/foundation.dart';

class AiringTodayTvShowsNotifier extends ChangeNotifier {
  final GetAiringTodayTvShows getAiringTodayTvShows;

  AiringTodayTvShowsNotifier(this.getAiringTodayTvShows);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvShow> _tvShows = [];
  List<TvShow> get tvShows => _tvShows;

  String _message = '';
  String get message => _message;

  Future<void> fetchAiringTodayTvShows() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getAiringTodayTvShows.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvShowsData) {
        _tvShows = tvShowsData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
