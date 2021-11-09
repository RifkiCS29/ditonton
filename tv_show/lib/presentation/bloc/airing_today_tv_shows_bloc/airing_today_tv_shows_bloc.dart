import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_show/domain/usecases/get_airing_today_tv_shows.dart';

part 'airing_today_tv_shows_event.dart';
part 'airing_today_tv_shows_state.dart';

class AiringTodayTvShowsBloc extends Bloc<AiringTodayTvShowsEvent, AiringTodayTvShowsState> {
  final GetAiringTodayTvShows getAiringTodayTvShows;
  AiringTodayTvShowsBloc(this.getAiringTodayTvShows) : super(AiringTodayTvShowsEmpty()) {
    on<AiringTodayTvShowsEvent>((event, emit) async {
      emit(AiringTodayTvShowsLoading());
      final result = await getAiringTodayTvShows.execute();
      result.fold(
        (failure) => emit(AiringTodayTvShowsError(failure.message)),
        (tvShowsData) => emit(AiringTodayTvShowsLoaded(tvShowsData)),
      );
    });
  }
}
