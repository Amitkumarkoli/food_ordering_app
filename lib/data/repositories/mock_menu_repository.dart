import 'dart:math';
import '../../core/error/failures.dart';
import '../models/menu_item.dart';
import 'menu_repository.dart';

class MockMenuRepository implements MenuRepository {
  @override
  Future<List<MenuItem>> getMenuItems(String restaurantId) async {
    await Future.delayed(const Duration(seconds: 1));
    if (Random().nextInt(10) == 0) {
      throw ServerFailure();
    }
    final allItems = [
      const MenuItem(id: 'm1', restaurantId: '1', name: 'Margherita Pizza', price: 12.99, imageUrl: 'https://via.placeholder.com/150?text=Pizza', category: 'Pizza'),
      const MenuItem(id: 'm2', restaurantId: '1', name: 'Pepperoni Pizza', price: 14.99, imageUrl: 'https://via.placeholder.com/150?text=Pizza', category: 'Pizza'),
      const MenuItem(id: 'm3', restaurantId: '2', name: 'Chicken Taco', price: 8.99, imageUrl: 'https://via.placeholder.com/150?text=Taco', category: 'Tacos'),
      const MenuItem(id: 'm4', restaurantId: '2', name: 'Beef Burrito', price: 9.99, imageUrl: 'https://via.placeholder.com/150?text=Burrito', category: 'Burritos'),
      const MenuItem(id: 'm5', restaurantId: '3', name: 'California Roll', price: 10.99, imageUrl: 'https://via.placeholder.com/150?text=Sushi', category: 'Sushi'),
      // Add more items for realism (10-15 total)
    ];
    return allItems.where((item) => item.restaurantId == restaurantId).toList();
  }
}