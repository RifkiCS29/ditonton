import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_show/presentation/bloc/top_rated_tv_shows_bloc/top_rated_tv_shows_bloc.dart';
import 'package:tv_show/presentation/pages/top_rated_tv_shows_page.dart';

import '../../dummy_data/dummy_objects.dart';

class TopRatedTvShowsEventFake extends Fake 
  implements TopRatedTvShowsEvent {}

class TopRatedTvShowsStateFake extends Fake 
  implements TopRatedTvShowsState {}

class MockTopRatedTvShowsBloc 
  extends MockBloc<TopRatedTvShowsEvent, TopRatedTvShowsState> 
  implements TopRatedTvShowsBloc {}

void main() {
  late MockTopRatedTvShowsBloc mockTopRatedTvShowsBloc;

  setUpAll(() {
    registerFallbackValue(TopRatedTvShowsEventFake());
    registerFallbackValue(TopRatedTvShowsStateFake());
  });

  setUp(() {
    mockTopRatedTvShowsBloc = MockTopRatedTvShowsBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvShowsBloc>.value(
      value: mockTopRatedTvShowsBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvShowsBloc.state).thenReturn(TopRatedTvShowsLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvShowsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvShowsBloc.state).thenReturn(TopRatedTvShowsLoaded([testTvShow]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvShowsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Empty',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvShowsBloc.state).thenReturn(TopRatedTvShowsEmpty());

    final textFinder = find.text('Empty Top Rated Tv Show');

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvShowsPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvShowsBloc.state).thenReturn(const TopRatedTvShowsError('Failed'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvShowsPage()));

    expect(textFinder, findsOneWidget);
  });
}
