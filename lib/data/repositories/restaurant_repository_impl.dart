import 'package:food_ordering_app/data/models/restaurant.dart';
import 'package:food_ordering_app/data/repositories/restaurant_repository.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  @override
  Future<List<Restaurant>> getRestaurants() async {
    // Multiple restaurants with real image URLs for visual appeal
    return [
      const Restaurant(
        id: '1',
        name: 'Pizza Palace',
        cuisine: 'Italian',
        rating: 4.5,
        imageUrl: 'https://images.unsplash.com/photo-1514933651103-9165c0b149b2', // Real pizza restaurant image from Unsplash
        deliveryTimeMinutes: 30,
      ),
      const Restaurant(
        id: '2',
        name: 'Sushi Spot',
        cuisine: 'Japanese',
        rating: 4.8,
        imageUrl: 'https://images.unsplash.com/photo-1534482425-4c3c2b5b0f5c', // Real sushi restaurant image from Unsplash
        deliveryTimeMinutes: 45,
      ),
      const Restaurant(
        id: '3',
        name: 'Burger Bonanza',
        cuisine: 'American',
        rating: 4.2,
        imageUrl: 'https://images.unsplash.com/photo-1552566626-52f8b828addc', // Real burger restaurant image from Unsplash
        deliveryTimeMinutes: 25,
      ),
      const Restaurant(
        id: '4',
        name: 'Taco Haven',
        cuisine: 'Mexican',
        rating: 4.6,
        imageUrl: 'https://images.unsplash.com/photo-1550949987-7e1e616682d8', // Real taco restaurant image from Unsplash
        deliveryTimeMinutes: 35,
      ),
      const Restaurant(
        id: '5',
        name: 'Curry Corner',
        cuisine: 'Indian',
        rating: 4.7,
        imageUrl: 'https://images.unsplash.com/photo-1565557623262-4776ef750882', // Real Indian restaurant image from Unsplash
        deliveryTimeMinutes: 40,
      ),
    ];
  }
}