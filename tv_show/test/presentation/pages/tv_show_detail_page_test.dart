import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/state_enum.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_show/presentation/bloc/tv_show_detail_bloc/tv_show_detail_bloc.dart';
import 'package:tv_show/presentation/pages/tv_show_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class TvShowDetailEventFake 
  extends Fake implements TvShowDetailEvent {}

class TvShowDetailStateFake 
  extends Fake implements TvShowDetailState {}

class MockTvShowDetailBloc 
  extends MockBloc<TvShowDetailEvent, TvShowDetailState>
  implements TvShowDetailBloc {}

void main() {
  late MockTvShowDetailBloc mockTvShowDetailBloc;

  setUpAll(() {
    registerFallbackValue(TvShowDetailEventFake());
    registerFallbackValue(TvShowDetailStateFake());
  });

  setUp(() {
    mockTvShowDetailBloc = MockTvShowDetailBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvShowDetailBloc>.value(
      value: mockTvShowDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Detail TvShow Page should display Progressbar when loading',
      (WidgetTester tester) async {
    when(() => mockTvShowDetailBloc.state).thenReturn(
      TvShowDetailState.initial().copyWith(
        tvShowDetailState: RequestState.Loading
      )
    );

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'should display loading when recommendationState loading',
      (WidgetTester tester) async {
    when(() => mockTvShowDetailBloc.state).thenReturn(
      TvShowDetailState.initial().copyWith(
        tvShowDetailState: RequestState.Loaded,
        tvShowDetail: testTvShowDetail,
        tvShowRecommendationState: RequestState.Loading,
        tvShowRecommendations: <TvShow>[],
        isAddedToWatchlist: false,
      )
    );

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));

    expect(progressBarFinder, findsWidgets);
  });

  testWidgets(
      'Watchlist button should display add icon when Tv Show not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvShowDetailBloc.state).thenReturn(
      TvShowDetailState.initial().copyWith(
        tvShowDetailState: RequestState.Loaded,
        tvShowDetail: testTvShowDetail,
        tvShowRecommendationState: RequestState.Loaded,
        tvShowRecommendations: [testTvShow],
        isAddedToWatchlist: false,
      )
    );

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when Tv Show is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockTvShowDetailBloc.state).thenReturn(
      TvShowDetailState.initial().copyWith(
        tvShowDetailState: RequestState.Loaded,
        tvShowDetail: testTvShowDetail,
        tvShowRecommendationState: RequestState.Loaded,
        tvShowRecommendations: [testTvShow],
        isAddedToWatchlist: true,
      )
    );

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    whenListen(
        mockTvShowDetailBloc,
        Stream.fromIterable([
          TvShowDetailState.initial().copyWith(
            tvShowDetailState: RequestState.Loaded,
            tvShowDetail: testTvShowDetail,
            tvShowRecommendationState: RequestState.Loaded,
            tvShowRecommendations: [testTvShow],
            isAddedToWatchlist: false,
          ),
          TvShowDetailState.initial().copyWith(
            tvShowDetailState: RequestState.Loaded,
            tvShowDetail: testTvShowDetail,
            tvShowRecommendationState: RequestState.Loaded,
            tvShowRecommendations: [testTvShow],
            isAddedToWatchlist: false,
            watchlistMessage: 'Added to Watchlist',
          ),
        ]),
        initialState: TvShowDetailState.initial()
    );

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));
    await tester.pump();

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

    testWidgets(
      'Watchlist button should display Snackbar when removed from watchlist',
      (WidgetTester tester) async {
    whenListen(
        mockTvShowDetailBloc,
        Stream.fromIterable([
          TvShowDetailState.initial().copyWith(
            tvShowDetailState: RequestState.Loaded,
            tvShowDetail: testTvShowDetail,
            tvShowRecommendationState: RequestState.Loaded,
            tvShowRecommendations: [testTvShow],
            isAddedToWatchlist: false,
          ),
          TvShowDetailState.initial().copyWith(
            tvShowDetailState: RequestState.Loaded,
            tvShowDetail: testTvShowDetail,
            tvShowRecommendationState: RequestState.Loaded,
            tvShowRecommendations: [testTvShow],
            isAddedToWatchlist: false,
            watchlistMessage: 'Removed from Watchlist',
          ),
        ]),
        initialState: TvShowDetailState.initial());

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));
    await tester.pump();

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Removed from Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    whenListen(
        mockTvShowDetailBloc,
        Stream.fromIterable([
          TvShowDetailState.initial().copyWith(
            tvShowDetailState: RequestState.Loaded,
            tvShowDetail: testTvShowDetail,
            tvShowRecommendationState: RequestState.Loaded,
            tvShowRecommendations: [testTvShow],
            isAddedToWatchlist: false,
          ),
          TvShowDetailState.initial().copyWith(
            tvShowDetailState: RequestState.Loaded,
            tvShowDetail: testTvShowDetail,
            tvShowRecommendationState: RequestState.Loaded,
            tvShowRecommendations: [testTvShow],
            isAddedToWatchlist: false,
            watchlistMessage: 'Failed',
          ),
          TvShowDetailState.initial().copyWith(
            tvShowDetailState: RequestState.Loaded,
            tvShowDetail: testTvShowDetail,
            tvShowRecommendationState: RequestState.Loaded,
            tvShowRecommendations: [testTvShow],
            isAddedToWatchlist: false,
            watchlistMessage: 'Failed ',
          ),
        ]),
        initialState: TvShowDetailState.initial());

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));
    await tester.pump();

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      'Detail Tv Show Page should display Error Text when No Internet Network (Error)',
      (WidgetTester tester) async {
    when(() => mockTvShowDetailBloc.state).thenReturn(
      TvShowDetailState.initial().copyWith(
        tvShowDetailState: RequestState.Error,
        message: 'Failed to connect to the network'
      )
    );

    final textErrorBarFinder = find.text('Failed to connect to the network');

    await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));
    await tester.pump();

    expect(textErrorBarFinder, findsOneWidget);
  });
}
