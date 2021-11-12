import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_show/domain/usecases/get_popular_tv_shows.dart';

part 'popular_tv_shows_event.dart';
part 'popular_tv_shows_state.dart';

class PopularTvShowsBloc extends Bloc<PopularTvShowsEvent, PopularTvShowsState> {
  final GetPopularTvShows getPopularTvShows;
  PopularTvShowsBloc(this.getPopularTvShows) : super(PopularTvShowsEmpty()) {
    on<PopularTvShowsEvent>((event, emit) async {
      emit(PopularTvShowsLoading());
      final result = await getPopularTvShows.execute();
      result.fold(
        (failure) => emit(PopularTvShowsError(failure.message)),
        (tvShowsData) {
          emit(PopularTvShowsLoaded(tvShowsData));
          if(tvShowsData.isEmpty) {
            emit(PopularTvShowsEmpty());
          }
        },
      );
    });
  }
}
