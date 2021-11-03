import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/presentation/pages/tv_show_detail_page.dart';
import 'package:ditonton/presentation/provider/tv_show_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_show_detail_page_test.mocks.dart';

@GenerateMocks([TvShowDetailNotifier])
void main() {
  late MockTvShowDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvShowDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvShowDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

    testWidgets(
      'Detail Tv Page should display Progressbar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.tvShowState).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));

    expect(progressBarFinder, findsOneWidget);
  });

    testWidgets(
      'should display loading when recommendationState loading',
      (WidgetTester tester) async {
    when(mockNotifier.tvShowState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvShow).thenReturn(testTvShowDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loading);
    when(mockNotifier.tvShowRecommendations).thenReturn(<TvShow>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));

    expect(progressBarFinder, findsWidgets);
  });

  testWidgets(
      'Watchlist button should display add icon when Tv Show not added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.tvShowState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvShow).thenReturn(testTvShowDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvShowRecommendations).thenReturn(<TvShow>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when Tv Show is added to wathclist',
      (WidgetTester tester) async {
    when(mockNotifier.tvShowState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvShow).thenReturn(testTvShowDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvShowRecommendations).thenReturn(<TvShow>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.tvShowState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvShow).thenReturn(testTvShowDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvShowRecommendations).thenReturn(<TvShow>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when removed from watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.tvShowState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvShow).thenReturn(testTvShowDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvShowRecommendations).thenReturn(<TvShow>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Removed from Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Removed from Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockNotifier.tvShowState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvShow).thenReturn(testTvShowDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvShowRecommendations).thenReturn(<TvShow>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

    testWidgets(
      'Detail Tv Show Page should display Error Text when No Internet Network (Error)',
      (WidgetTester tester) async {
    when(mockNotifier.tvShowState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Failed to connect to the network');

    final textErrorBarFinder = find.text('Failed to connect to the network');

    await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));

    expect(textErrorBarFinder, findsOneWidget);
  });
}
