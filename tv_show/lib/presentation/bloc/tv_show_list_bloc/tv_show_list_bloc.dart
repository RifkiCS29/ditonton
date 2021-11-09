import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_show/domain/usecases/get_airing_today_tv_shows.dart';
import 'package:tv_show/domain/usecases/get_popular_tv_shows.dart';
import 'package:tv_show/domain/usecases/get_top_rated_tv_shows.dart';

part 'tv_show_list_event.dart';
part 'tv_show_list_state.dart';

class AiringTodayTvShowListBloc extends Bloc<TvShowListEvent, TvShowListState> {
  final GetAiringTodayTvShows getAiringTodayTvShows;
  AiringTodayTvShowListBloc(this.getAiringTodayTvShows) : super(TvShowListEmpty()) {
    on<TvShowListEvent>((event, emit) async {
      emit(TvShowListLoading());
      final result = await getAiringTodayTvShows.execute();
      result.fold(
        (failure) => emit(TvShowListError(failure.message)),
        (tvShowsData) => emit(TvShowListLoaded(tvShowsData)),
      );
    });
  }
}

class PopularTvShowListBloc extends Bloc<TvShowListEvent, TvShowListState> {
  final GetPopularTvShows getPopularTvShows;
  PopularTvShowListBloc(this.getPopularTvShows) : super(TvShowListEmpty()) {
    on<TvShowListEvent>((event, emit) async {
      emit(TvShowListLoading());
      final result = await getPopularTvShows.execute();
      result.fold(
        (failure) => emit(TvShowListError(failure.message)),
        (tvShowsData) => emit(TvShowListLoaded(tvShowsData)),
      );
    });
  }
}

class TopRatedTvShowListBloc extends Bloc<TvShowListEvent, TvShowListState> {
  final GetTopRatedTvShows getTopRatedTvShows;
  TopRatedTvShowListBloc(this.getTopRatedTvShows) : super(TvShowListEmpty()) {
    on<TvShowListEvent>((event, emit) async {
      emit(TvShowListLoading());
      final result = await getTopRatedTvShows.execute();
      result.fold(
        (failure) => emit(TvShowListError(failure.message)),
        (tvShowsData) => emit(TvShowListLoaded(tvShowsData)),
      );
    });
  }
}
