import 'dart:math';
import '../../core/error/failures.dart';
import '../models/restaurant.dart';
import 'restaurant_repository.dart';

class MockRestaurantRepository implements RestaurantRepository {
  @override
  Future<List<Restaurant>> getRestaurants() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    if (Random().nextInt(10) == 0) { // 10% chance of error
      throw ServerFailure();
    }
    return [
      const Restaurant(
        id: '1',
        name: 'Pizza Palace',
        cuisine: 'Italian',
        rating: 4.5,
        imageUrl: 'https://via.placeholder.com/150?text=Pizza',
        deliveryTimeMinutes: 30,
      ),
      const Restaurant(
        id: '2',
        name: 'Taco Haven',
        cuisine: 'Mexican',
        rating: 4.2,
        imageUrl: 'https://via.placeholder.com/150?text=Tacos',
        deliveryTimeMinutes: 25,
      ),
      const Restaurant(
        id: '3',
        name: 'Sushi Spot',
        cuisine: 'Japanese',
        rating: 4.8,
        imageUrl: 'https://via.placeholder.com/150?text=Sushi',
        deliveryTimeMinutes: 40,
      ),
      const Restaurant(
        id: '4',
        name: 'Burger Bonanza',
        cuisine: 'American',
        rating: 4.0,
        imageUrl: 'https://via.placeholder.com/150?text=Burger',
        deliveryTimeMinutes: 20,
      ),
      const Restaurant(
        id: '5',
        name: 'Curry Corner',
        cuisine: 'Indian',
        rating: 4.6,
        imageUrl: 'https://via.placeholder.com/150?text=Curry',
        deliveryTimeMinutes: 35,
      ),
    ];
  }
}