import 'package:dicoding_final/features/explore_restaurants/data/models/restaurant_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class RestaurantDao {
  @insert
  Future<void> saveRestaurant(RestaurantModel restaurant);

  @delete
  Future<void> deleteSavedRestaurant(RestaurantModel restaurant);

  @Query('SELECT * FROM restaurant')
  Future<List<RestaurantModel>> getRestaurants();
}
