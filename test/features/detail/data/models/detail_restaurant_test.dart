import 'dart:convert';

import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/detail/data/models/detail_restaurant_model.dart';
import 'package:dicoding_final/features/detail/domain/entities/detail_restaurant.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  const tRestaurant = DetailRestaurantModel.empty();
  final tRestaurantJson =
      jsonDecode(fixtureReader('detail_restaurant.json')) as ResultMap;

  test('Should be a subclass of [DetailRestaurant] entity', () {
    // assert
    expect(tRestaurant, equals(isA<DetailRestaurant>()));
  });

  group('fromJson', () {
    test('Should return a valid model when data is json', () async {
      // act
      final result = DetailRestaurantModel.fromJson(
        tRestaurantJson['restaurant'] as ResultMap,
      );
      // assert
      expect(result, tRestaurant);
    });
  });

  group('toJson', () {
    test('Should convert [RestaurantModel] to Map<String, dynamic>', () async {
      // act
      final result = tRestaurant.toJson();
      final expectedMap = {
        'id': '',
        'name': '',
        'description': '',
        'city': '',
        'address': '',
        'pictureId': '',
        'categories': [
          {'name': ''},
        ],
        'menus': {
          'foods': [
            {'name': ''},
          ],
          'drinks': [
            {'name': ''},
          ],
        },
        'rating': 1.1,
        'customerReviews': [
          {'name': '', 'review': '', 'date': ''},
        ],
      };
      // assert
      expect(result, equals(expectedMap));
    });
  });
}
