
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:ditonton/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Integration Test: ', () {
    testWidgets('Tap on the watchlist action button Movie or TvShow then verify watchlist',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Click first item movie
      final Finder movieItem = find.byKey(Key('movieItem')).first;
      await tester.tap(movieItem);
      await tester.pumpAndSettle();

      // Click the watchlistButtonMovie and check "Icon Check"
      final Finder watchListButtonMovie = find.byKey(Key('watchlistButtonMovie'));
      await tester.tap(watchListButtonMovie);
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.check), findsOneWidget);

      // Back to home screen
      final Finder iconBack = find.byIcon(Icons.arrow_back).first;
      await tester.tap(iconBack);
      await tester.pumpAndSettle();

      //open drawer
      final Finder drawerIcon = find.byIcon(Icons.menu).first;
      await tester.tap(drawerIcon);
      await tester.pumpAndSettle();

      //click on Tv Show menu
      final Finder tvShowIcon = find.byIcon(Icons.tv).first;
      await tester.tap(tvShowIcon);
      await tester.pumpAndSettle();

      // Click the first item Tv Show 
      final Finder tvShowItem = find.byKey(Key('tvShowItem')).first;
      await tester.tap(tvShowItem);
      await tester.pumpAndSettle();

      // Click the watchlistButtonTvShow and check "Icon Check"
      final Finder watchListButtonTvShow = find.byKey(Key('watchlistButtonTvShow'));
      await tester.tap(watchListButtonTvShow);
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.check), findsOneWidget);

      //Back to Home
      await tester.tap(iconBack);
      await tester.pumpAndSettle();

      //open drawer and click watchlist menu
      await tester.tap(drawerIcon);
      await tester.pumpAndSettle();
      final Finder watchlistMenuIcon = find.byIcon(Icons.save_alt).first;
      await tester.tap(watchlistMenuIcon);
      await tester.pumpAndSettle();

      //find moviecard
      expect(find.byType(MovieCard), findsOneWidget);

      //click tab Tv Shows and check TvShowCard
      final Finder tvShowTab = find.text('Tv Shows');
      await tester.tap(tvShowTab);
      await tester.pumpAndSettle();
      expect(find.byType(TvShowCard), findsOneWidget);
    });
  });
}