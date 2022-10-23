import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tv_shows.dart';
import 'package:search/presentation/bloc/search_bloc.dart';

import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies, SearchTvShows])
void main() {
  late SearchMovieBloc searchMovieBloc;
  late SearchTvShowBloc searchTvShowBloc;
  late MockSearchMovies mockSearchMovies;
  late MockSearchTvShows mockSearchTvShows;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    mockSearchTvShows = MockSearchTvShows();
    searchMovieBloc = SearchMovieBloc(mockSearchMovies);
    searchTvShowBloc = SearchTvShowBloc(mockSearchTvShows);
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  const tQuery = 'spiderman';

  group('Search Movies', () {

    test('Initial state should be empty', () {
      expect(searchMovieBloc.state, SearchEmpty(''));
    });

    blocTest<SearchMovieBloc, SearchState> (
      'Should emit [SearchLoading, SearchHasData] when data is gotten successfully',
      build: () {
        when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
        return searchMovieBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );
    
    blocTest<SearchMovieBloc, SearchState> (
      'Should emit [SearchLoading, SearchHasData[], SearchEmpty] when data is empty',
      build: () {
        when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(<Movie>[]));
        return searchMovieBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchHasData(const <Movie>[]),
        SearchEmpty('No Result Found'),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );

    blocTest<SearchMovieBloc, SearchState> (
      'Should emit [SearchLoading, SearchError] when data is unsuccessful',
      build: () {
        when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchMovieBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );
  });

  final tTvShowModel = TvShow(
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
      voteCount: 987
  );
  final tTvShowList = <TvShow>[tTvShowModel];
  const tQueryTvShow = 'chucky';

  group('Search Tv Shows', () {
    
    test('Initial state should be empty', () {
      expect(searchTvShowBloc.state, SearchEmpty(''));
    });

    blocTest<SearchTvShowBloc, SearchState> (
      'Should emit [SearchLoading, SearchHasData] when data is gotten successfully',
      build: () {
        when(mockSearchTvShows.execute(tQueryTvShow))
          .thenAnswer((_) async => Right(tTvShowList));
        return searchTvShowBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQueryTvShow)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchHasData(tTvShowList),
      ],
      verify: (bloc) {
        verify(mockSearchTvShows.execute(tQueryTvShow));
      },
    );
    
    blocTest<SearchTvShowBloc, SearchState> (
      'Should emit [SearchLoading, SearchHasData[], SearchEmpty] when data is empty',
      build: () {
        when(mockSearchTvShows.execute(tQueryTvShow))
          .thenAnswer((_) async => Right(<TvShow>[]));
        return searchTvShowBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQueryTvShow)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchHasData(const <TvShow>[]),
        SearchEmpty('No Result Found'),
      ],
      verify: (bloc) {
        verify(mockSearchTvShows.execute(tQueryTvShow));
      },
    );

    blocTest<SearchTvShowBloc, SearchState> (
      'Should emit [SearchLoading, SearchError] when data is unsuccessful',
      build: () {
        when(mockSearchTvShows.execute(tQueryTvShow))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchTvShowBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQueryTvShow)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchTvShows.execute(tQueryTvShow));
      },
    );
  });
}
