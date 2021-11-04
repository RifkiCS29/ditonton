import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final Map<String, dynamic> movieTableJson = {
    'id': 1,
    'title': 'title',
    'posterPath': 'posterPath',
    'overview': 'overview',
  };

  test('should return json movie table correctly', () {
    final result = testMovieTable.toJson();
    expect(result, movieTableJson);
  });
}