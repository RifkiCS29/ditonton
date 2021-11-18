import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_show/presentation/bloc/tv_show_season_episodes/tv_show_season_episodes_bloc.dart';
import 'package:tv_show/presentation/pages/tv_show_season_episodes_page.dart';

import '../../dummy_data/dummy_objects.dart';

class TvShowSeasonEpisodesEventFake extends Fake 
  implements TvShowSeasonEpisodesEvent {}

class TvShowSeasonEpisodesStateFake extends Fake 
  implements TvShowSeasonEpisodesState {}

class MockTvShowSeasonEpisodesBloc 
  extends MockBloc<TvShowSeasonEpisodesEvent, TvShowSeasonEpisodesState> 
  implements TvShowSeasonEpisodesBloc {}

void main() {
  late MockTvShowSeasonEpisodesBloc mockTvShowSeasonEpisodesBloc;

  setUpAll(() {
    registerFallbackValue(TvShowSeasonEpisodesEventFake());
    registerFallbackValue(TvShowSeasonEpisodesStateFake());
  });

  setUp(() {
    mockTvShowSeasonEpisodesBloc = MockTvShowSeasonEpisodesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvShowSeasonEpisodesBloc>.value(
      value: mockTvShowSeasonEpisodesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTvShowSeasonEpisodesBloc.state).thenReturn(TvShowSeasonEpisodesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(
      TvShowSeasonEpisodesPage(id: 1, seasonNumber: 1)
    ));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTvShowSeasonEpisodesBloc.state).thenReturn(
      TvShowSeasonEpisodesLoaded([testEpisode])
    );

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(
      TvShowSeasonEpisodesPage(id: 1, seasonNumber: 1)
    ));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Empty',
      (WidgetTester tester) async {
    when(() => mockTvShowSeasonEpisodesBloc.state).thenReturn(TvShowSeasonEpisodesEmpty());

    final textFinder = find.text('Empty Episode');

    await tester.pumpWidget(_makeTestableWidget(
      TvShowSeasonEpisodesPage(id: 1, seasonNumber: 1)
    ));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTvShowSeasonEpisodesBloc.state).thenReturn(TvShowSeasonEpisodesError('Failed'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(
      TvShowSeasonEpisodesPage(id: 1, seasonNumber: 1)
    ));

    expect(textFinder, findsOneWidget);
  });
}