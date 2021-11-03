import 'package:core/common/state_enum.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:tv_show/domain/usecases/get_tv_show_season_episodes.dart';
import 'package:flutter/foundation.dart';

class TvShowSeasonEpisodesNotifier extends ChangeNotifier {
  final GetTvShowSeasonEpisodes getTvShowSeasonEpisodes;

  TvShowSeasonEpisodesNotifier({required this.getTvShowSeasonEpisodes});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Episode> _episodes = [];
  List<Episode> get episode => _episodes;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvShowSeasonEpisodes(int id, int seasonNumber) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTvShowSeasonEpisodes.execute(id, seasonNumber);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (episodesData) {
        _episodes = episodesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
