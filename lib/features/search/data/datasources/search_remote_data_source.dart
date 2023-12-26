import 'dart:convert';

import 'package:dicoding_final/core/errors/exception.dart';
import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/dashboard/data/models/restaurant_model.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

abstract class SearchRemoteDataSource {
  const SearchRemoteDataSource();

  /// Calls the https://restaurant-api.dicoding.dev//search?q=<query> endpoint.
  ///
  /// Throw a [ServerException] for all the error codes.
  Future<List<RestaurantModel>> searchRestaurant(String restaurantName);
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  const SearchRemoteDataSourceImpl({required http.Client client})
      : _client = client;
  final http.Client _client;

  @override
  Future<List<RestaurantModel>> searchRestaurant(String restaurantName) async {
    try {
      final response = await _client.get(
        Uri.parse(
          'https://restaurant-api.dicoding.dev//search?q=$restaurantName',
        ),
      );

      if (response.statusCode != 200) {
        throw ServerException(message: response.body);
      }

      final decode = jsonDecode(response.body) as ResultMap;
      if (decode['error'] == true) {
        throw ServerException(message: response.body);
      }
      final result = (decode['restaurants'] as List<dynamic>)
          .map(
            (restaurant) => RestaurantModel.fromJson(restaurant as ResultMap),
          )
          .toList();
      return result;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString());
    }
  }
}
