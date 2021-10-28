import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final Map<String, dynamic> tvShowTableJson = {
    'id': 1,
    'name': 'name',
    'posterPath': 'posterPath',
    'overview': 'overview',
  };

  test('should return json Tv Show table correctly', () {
    final result = testTvShowTable.toJson();
    expect(result, tvShowTableJson);
  });
}