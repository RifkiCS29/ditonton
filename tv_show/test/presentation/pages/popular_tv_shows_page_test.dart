import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_show/presentation/bloc/popular_tv_shows_bloc/popular_tv_shows_bloc.dart';
import 'package:tv_show/presentation/pages/popular_tv_shows_page.dart';

import '../../dummy_data/dummy_objects.dart';

class PopularTvShowsEventFake extends Fake 
  implements PopularTvShowsEvent {}

class PopularTvShowsStateFake extends Fake 
  implements PopularTvShowsState {}

class MockPopularTvShowsBloc 
  extends MockBloc<PopularTvShowsEvent, PopularTvShowsState> 
  implements PopularTvShowsBloc {}

void main() {
  late MockPopularTvShowsBloc mockPopularTvShowsBloc;

  setUpAll(() {
    registerFallbackValue(PopularTvShowsEventFake());
    registerFallbackValue(PopularTvShowsStateFake());
  });

  setUp(() {
    mockPopularTvShowsBloc = MockPopularTvShowsBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvShowsBloc>.value(
      value: mockPopularTvShowsBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularTvShowsBloc.state).thenReturn(PopularTvShowsLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvShowsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularTvShowsBloc.state).thenReturn(PopularTvShowsLoaded([testTvShow]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvShowsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Empty',
      (WidgetTester tester) async {
    when(() => mockPopularTvShowsBloc.state).thenReturn(PopularTvShowsEmpty());

    final textFinder = find.text('Empty Popular Tv Show');

    await tester.pumpWidget(_makeTestableWidget(const PopularTvShowsPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularTvShowsBloc.state).thenReturn(const PopularTvShowsError('Failed'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularTvShowsPage()));

    expect(textFinder, findsOneWidget);
  });
}
