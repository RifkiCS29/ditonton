import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/domain/usecases/get_popular_tv_shows.dart';
import 'package:tv_show/presentation/bloc/popular_tv_shows_bloc/popular_tv_shows_bloc.dart';

import 'popular_tv_shows_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvShows])
void main() {
  late MockGetPopularTvShows mockGetPopularTvShows;
  late PopularTvShowsBloc popularTvShowsBloc;

  setUp(() {
    mockGetPopularTvShows = MockGetPopularTvShows();
    popularTvShowsBloc = PopularTvShowsBloc(mockGetPopularTvShows);
  });
  
  final tTvShow = TvShow(
      backdropPath: "/xAKMj134XHQVNHLC6rWsccLMenG.jpg",
      firstAirDate: "2021-10-12",
      genreIds: const [10765, 35, 80],
      id: 90462,
      name: "Chucky",
      originalName: "Chucky",
      overview:
          "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the town’s hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chucky’s past threatens to expose the truth behind the killings, as well as the demon doll’s untold origins.",
      popularity: 6008.272,
      posterPath: "/iF8ai2QLNiHV4anwY1TuSGZXqfN.jpg",
      voteAverage: 8,
      voteCount: 987,
  );

  final tTvShowList = <TvShow>[tTvShow];

  group('Popular Tv Shows', () {
    test('Initial state should be empty', () {
      expect(popularTvShowsBloc.state, PopularTvShowsEmpty());
    });

    blocTest<PopularTvShowsBloc, PopularTvShowsState> (
      'Should emit [PopularTvShowsLoading, PopularTvShowsLoaded] when data is gotten successfully',
      build: () {
        when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
        return popularTvShowsBloc;
      },
      act: (bloc) => bloc.add(PopularTvShowsEvent()),
      expect: () => [
        PopularTvShowsLoading(),
        PopularTvShowsLoaded(tTvShowList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTvShows.execute());
      },
    );

    blocTest<PopularTvShowsBloc, PopularTvShowsState> (
      'Should emit [PopularTvShowsLoading, PopularTvShowsLoaded[], PopularTvShowsEmpty] when data is gotten successfully',
      build: () {
        when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => const Right(<TvShow>[]));
        return popularTvShowsBloc;
      },
      act: (bloc) => bloc.add(PopularTvShowsEvent()),
      expect: () => [
        PopularTvShowsLoading(),
        const PopularTvShowsLoaded(<TvShow>[]),
        PopularTvShowsEmpty(),
      ],
      verify: (bloc) {
        verify(mockGetPopularTvShows.execute());
      },
    );

    blocTest<PopularTvShowsBloc, PopularTvShowsState> (
      'Should emit [PopularTvShowsLoading, PopularTvShowsError] when get Failure',
      build: () {
        when(mockGetPopularTvShows.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        return popularTvShowsBloc;
      },
      act: (bloc) => bloc.add(PopularTvShowsEvent()),
      expect: () => [
        PopularTvShowsLoading(),
        const PopularTvShowsError('Failed'),
      ],
      verify: (_) {
        verify(mockGetPopularTvShows.execute());
      },
    );
  });
}
