import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_show/domain/usecases/get_top_rated_tv_shows.dart';

part 'top_rated_tv_shows_event.dart';
part 'top_rated_tv_shows_state.dart';

class TopRatedTvShowsBloc extends Bloc<TopRatedTvShowsEvent, TopRatedTvShowsState> {
  final GetTopRatedTvShows getTopRatedTvShows;
  TopRatedTvShowsBloc(this.getTopRatedTvShows) : super(TopRatedTvShowsEmpty()) {
    on<TopRatedTvShowsEvent>((event, emit) async {
      emit(TopRatedTvShowsLoading());
      final result = await getTopRatedTvShows.execute();
      result.fold(
        (failure) => emit(TopRatedTvShowsError(failure.message)),
        (tvShowsData) {
          emit(TopRatedTvShowsLoaded(tvShowsData));
          if(tvShowsData.isEmpty) {
            emit(TopRatedTvShowsEmpty());
          }
        } ,
      );
    });
  }
}
