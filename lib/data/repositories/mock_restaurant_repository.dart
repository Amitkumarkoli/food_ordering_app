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
        imageUrl: 'https://www.shutterstock.com/image-photo/covent-garden-london-united-kingdom-260nw-2378281951.jpg', // Real Italian restaurant
        deliveryTimeMinutes: 30,
      ),
      const Restaurant(
        id: '2',
        name: 'Sushi Spot',
        cuisine: 'Japanese',
        rating: 4.8,
        imageUrl: 'https://www.shutterstock.com/shutterstock/videos/1108361283/thumb/1.jpg?ip=x480', // Real sushi restaurant
        deliveryTimeMinutes: 45,
      ),
      const Restaurant(
        id: '3',
        name: 'Burger Bonanza',
        cuisine: 'American',
        rating: 4.2,
        imageUrl: 'https://media.gettyimages.com/id/1592927233/photo/danville-pennsylvania-united-states-an-exterior-view-of-burger-king-a-fast-food-restaurant.jpg?s=612x612&w=gi&k=20&c=Hqz5hJa0BzvBi_OjrCWIa6h6kt-SD_DY9gLSUipeqUM=', // Real burger restaurant
        deliveryTimeMinutes: 25,
      ),
      const Restaurant(
        id: '4',
        name: 'Taco Haven',
        cuisine: 'Mexican',
        rating: 4.6,
        imageUrl: 'https://media.gettyimages.com/id/1945793217/photo/gastonia-north-carolina-taco-bell-mexican-fast-food-restaurant-and-drive-thru-at-dusk.jpg?s=612x612&w=gi&k=20&c=zKNGJPQJrBQSf6J6qk2hqApvA56wjTsVU2nxrXX_p1M=', // Real taco restaurant
        deliveryTimeMinutes: 35,
      ),
      const Restaurant(
        id: '5',
        name: 'Curry Corner',
        cuisine: 'Indian',
        rating: 4.7,
        imageUrl: 'https://www.shutterstock.com/image-photo/arles-france-sept-9th-2023-260nw-2388441121.jpg', // Real Indian restaurant
        deliveryTimeMinutes: 40,
      ),
    ];
  }
}