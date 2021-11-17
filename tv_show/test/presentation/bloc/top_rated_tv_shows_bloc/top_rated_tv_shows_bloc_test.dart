import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/domain/usecases/get_top_rated_tv_shows.dart';
import 'package:tv_show/presentation/bloc/top_rated_tv_shows_bloc/top_rated_tv_shows_bloc.dart';

import 'top_rated_tv_shows_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvShows])
void main() {
  late MockGetTopRatedTvShows mockGetTopRatedTvShows;
  late TopRatedTvShowsBloc topRatedTvShowsBloc;

  setUp(() {
    mockGetTopRatedTvShows = MockGetTopRatedTvShows();
    topRatedTvShowsBloc = TopRatedTvShowsBloc(mockGetTopRatedTvShows);
  });
  
  final tTvShow = TvShow(
      backdropPath: "/xAKMj134XHQVNHLC6rWsccLMenG.jpg",
      firstAirDate: "2021-10-12",
      genreIds: [10765, 35, 80],
      id: 90462,
      name: "Chucky",
      originalName: "Chucky",
      overview:
          "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the town’s hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chucky’s past threatens to expose the truth behind the killings, as well as the demon doll’s untold origins.",
      popularity: 6008.272,
      posterPath: "/iF8ai2QLNiHV4anwY1TuSGZXqfN.jpg",
      voteAverage: 8,
      voteCount: 987
  );

  final tTvShowList = <TvShow>[tTvShow];

  group('Top Rated Tv Shows', () {
    test('Initial state should be empty', () {
      expect(topRatedTvShowsBloc.state, TopRatedTvShowsEmpty());
    });

    blocTest<TopRatedTvShowsBloc, TopRatedTvShowsState> (
      'Should emit [TopRatedTvShowsLoading, TopRatedTvShowsLoaded] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
        return topRatedTvShowsBloc;
      },
      act: (bloc) => bloc.add(TopRatedTvShowsEvent()),
      expect: () => [
        TopRatedTvShowsLoading(),
        TopRatedTvShowsLoaded(tTvShowList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTvShows.execute());
      },
    );

    blocTest<TopRatedTvShowsBloc, TopRatedTvShowsState> (
      'Should emit [TopRatedTvShowsLoading, TopRatedTvShowsLoaded[], TopRatedTvShowsEmpty] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTvShows.execute())
          .thenAnswer((_) async => Right(<TvShow>[]));
        return topRatedTvShowsBloc;
      },
      act: (bloc) => bloc.add(TopRatedTvShowsEvent()),
      expect: () => [
        TopRatedTvShowsLoading(),
        TopRatedTvShowsLoaded(<TvShow>[]),
        TopRatedTvShowsEmpty(),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTvShows.execute());
      },
    );

    blocTest<TopRatedTvShowsBloc, TopRatedTvShowsState> (
      'Should emit [TopRatedTvShowsLoading, TopRatedTvShowsError] when get Failure',
      build: () {
        when(mockGetTopRatedTvShows.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return topRatedTvShowsBloc;
      },
      act: (bloc) => bloc.add(TopRatedTvShowsEvent()),
      expect: () => [
        TopRatedTvShowsLoading(),
        TopRatedTvShowsError('Failed'),
      ],
      verify: (_) {
        verify(mockGetTopRatedTvShows.execute());
      },
    );
  });
}
