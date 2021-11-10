import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tv_show_detail_event.dart';
part 'tv_show_detail_state.dart';

class TvShowDetailBloc extends Bloc<TvShowDetailEvent, TvShowDetailState> {
  TvShowDetailBloc() : super(TvShowDetailInitial()) {
    on<TvShowDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
