import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_show/presentation/bloc/airing_today_tv_shows_bloc/airing_today_tv_shows_bloc.dart';
import 'package:tv_show/presentation/pages/airing_today_tv_show_page.dart';

import '../../dummy_data/dummy_objects.dart';

class AiringTodayTvShowsEventFake extends Fake 
  implements AiringTodayTvShowsEvent {}

class AiringTodayTvShowsStateFake extends Fake 
  implements AiringTodayTvShowsState {}

class MockAiringTodayTvShowsBloc 
  extends MockBloc<AiringTodayTvShowsEvent, AiringTodayTvShowsState> 
  implements AiringTodayTvShowsBloc {}

void main() {
  late MockAiringTodayTvShowsBloc mockAiringTodayTvShowsBloc;

  setUpAll(() {
    registerFallbackValue(AiringTodayTvShowsEventFake());
    registerFallbackValue(AiringTodayTvShowsStateFake());
  });

  setUp(() {
    mockAiringTodayTvShowsBloc = MockAiringTodayTvShowsBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<AiringTodayTvShowsBloc>.value(
      value: mockAiringTodayTvShowsBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockAiringTodayTvShowsBloc.state).thenReturn(AiringTodayTvShowsLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const AiringTodayTvShowsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockAiringTodayTvShowsBloc.state).thenReturn(AiringTodayTvShowsLoaded([testTvShow]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const AiringTodayTvShowsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Empty',
      (WidgetTester tester) async {
    when(() => mockAiringTodayTvShowsBloc.state).thenReturn(AiringTodayTvShowsEmpty());

    final textFinder = find.text('Empty Airing Today Tv Show');

    await tester.pumpWidget(_makeTestableWidget(const AiringTodayTvShowsPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockAiringTodayTvShowsBloc.state).thenReturn(const AiringTodayTvShowsError('Failed'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const AiringTodayTvShowsPage()));

    expect(textFinder, findsOneWidget);
  });
}
