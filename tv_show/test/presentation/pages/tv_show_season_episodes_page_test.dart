import 'package:core/common/state_enum.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:tv_show/presentation/pages/tv_show_season_episodes_page.dart';
import 'package:tv_show/presentation/provider/tv_show_season_episodes_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'tv_show_season_episodes_page_test.mocks.dart';

@GenerateMocks([TvShowSeasonEpisodesNotifier])
void main() {
  late MockTvShowSeasonEpisodesNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvShowSeasonEpisodesNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvShowSeasonEpisodesNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TvShowSeasonEpisodesPage(id: 1, seasonNumber: 1)));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.episode).thenReturn(<Episode>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TvShowSeasonEpisodesPage(id: 1, seasonNumber: 1)));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TvShowSeasonEpisodesPage(id: 1, seasonNumber: 1)));

    expect(textFinder, findsOneWidget);
  });
}
