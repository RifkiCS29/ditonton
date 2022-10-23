import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:core/presentation/widgets/episode_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const episode = Episode(
    airDate: '2021-09-17',
    episodeNumber: 1,
    id: 1922715,
    name: 'Red Light, Green Light',
    overview: 'Hoping to win easy money, a broke and desperate Gi-hun agrees to take part in an enigmatic game. Not long into the first round, unforeseen horrors unfold.',
    productionCode: '',
    seasonNumber: 1,
    stillPath: '/vMFJS9LIUUAmQ1thq4vJ7iHKwRz.jpg',
    voteAverage: 8.1,
    voteCount: 51,
  );

  group('Episode card list Widget Test', () {
    Widget _makeTestableWidget() {
      return const MaterialApp(home: Scaffold(body: EpisodeCard(episode)));
    }

    testWidgets('Testing if name episode shows', (WidgetTester tester) async {
      await tester.pumpWidget(_makeTestableWidget());
      expect(find.byType(Text), findsWidgets);
      expect(find.byIcon(Icons.access_alarm), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });
  });
}