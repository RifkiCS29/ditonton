import 'package:core/data/models/genre_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tGenreModel = GenreModel(
    id: 1,
    name: 'genre',
  );

  const tGenre = Genre(
    id: 1,
    name: 'genre',
  );

  final tGenreJson = {
    'id': 1,
    'name': 'genre',
  };

  test('should be a subclass Genre entity', () async {
    final result = tGenreModel.toEntity();
    expect(result, tGenre);
  });

  test('should be a subclass Genre Json', () async {
    final result = tGenreModel.toJson();
    expect(result, tGenreJson);
  });
}