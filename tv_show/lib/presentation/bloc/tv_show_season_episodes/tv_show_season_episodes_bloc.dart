import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_show/domain/usecases/get_tv_show_season_episodes.dart';

part 'tv_show_season_episodes_event.dart';
part 'tv_show_season_episodes_state.dart';

class TvShowSeasonEpisodesBloc 
  extends Bloc<TvShowSeasonEpisodesEvent, TvShowSeasonEpisodesState> {
  final GetTvShowSeasonEpisodes getTvShowSeasonEpisodes;
  TvShowSeasonEpisodesBloc(this.getTvShowSeasonEpisodes) : super(TvShowSeasonEpisodesEmpty()) {
    on<FetchTvShowSeasonEpisodesEvent>((event, emit) async{
      emit(TvShowSeasonEpisodesLoading());
      final result = await getTvShowSeasonEpisodes.execute(event.id, event.seasonNumber);
      result.fold(
        (failure) => emit(TvShowSeasonEpisodesError(failure.message)),
        (episodesData) {
          emit(TvShowSeasonEpisodesLoaded(episodesData));
          if(episodesData.isEmpty) {
            emit(TvShowSeasonEpisodesEmpty());
          }
        }
      );
    });
  }
}
