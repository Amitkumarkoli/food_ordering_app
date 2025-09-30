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
      const MenuItem(
          id: 'm1',
          restaurantId: '1',
          name: 'Margherita Pizza',
          price: 12.99,
          imageUrl:
              'https://media.istockphoto.com/id/1393150881/photo/italian-pizza-margherita-with-cheese-and-tomato-sauce-on-the-board-on-grey-table-macro-close.jpg?s=612x612&w=0&k=20&c=kL0Vhg2XKBjEl__iG8sFv31WTiahdpLc3rTDtNZuD2g=',
          category: 'Pizza'),
      const MenuItem(
          id: 'm2',
          restaurantId: '1',
          name: 'Pepperoni Pizza',
          price: 14.99,
          imageUrl:
              'https://media.istockphoto.com/id/1393150881/photo/italian-pizza-margherita-with-cheese-and-tomato-sauce-on-the-board-on-grey-table-macro-close.jpg?s=612x612&w=0&k=20&c=kL0Vhg2XKBjEl__iG8sFv31WTiahdpLc3rTDtNZuD2g=',
          category: 'Pizza'),
      const MenuItem(
          id: 'm3',
          restaurantId: '2',
          name: 'California Roll',
          price: 10.99,
          imageUrl:
              'https://norecipes.com/wp-content/uploads/2019/12/best-california-roll-003.jpg',
          category: 'Sushi'),
      const MenuItem(
          id: 'm4',
          restaurantId: '2',
          name: 'Spicy Tuna Roll',
          price: 12.99,
          imageUrl:
              'https://norecipes.com/wp-content/uploads/2019/12/best-california-roll-003.jpg',
          category: 'Sushi'),
      const MenuItem(
          id: 'm5',
          restaurantId: '3',
          name: 'Classic Burger',
          price: 9.99,
          imageUrl:
              'https://assets2.kansascitysteaks.com/dyn-images/pdp_hero/6006_Classic_Steakbu-ca9fa7f3da1cef488ae2303889ec6b69.jpg',
          category: 'Burgers'),
      const MenuItem(
          id: 'm6',
          restaurantId: '3',
          name: 'Cheese Burger',
          price: 10.99,
          imageUrl:
              'https://assets2.kansascitysteaks.com/dyn-images/pdp_hero/6006_Classic_Steakbu-ca9fa7f3da1cef488ae2303889ec6b69.jpg',
          category: 'Burgers'),
      const MenuItem(
          id: 'm7',
          restaurantId: '4',
          name: 'Chicken Taco',
          price: 8.99,
          imageUrl:
              'https://pinchofyum.com/wp-content/uploads/Chicken-Tinga-Tacos-6.jpg',
          category: 'Tacos'),
      const MenuItem(
          id: 'm8',
          restaurantId: '4',
          name: 'Beef Taco',
          price: 9.99,
          imageUrl:
              'https://pinchofyum.com/wp-content/uploads/Chicken-Tinga-Tacos-6.jpg',
          category: 'Tacos'),
      const MenuItem(
          id: 'm9',
          restaurantId: '5',
          name: 'Butter Chicken',
          price: 11.99,
          imageUrl:
              'https://vikalinka.com/wp-content/uploads/2018/04/Butter-Chicken-Curry-1-Edit.jpg',
          category: 'Curries'),
      const MenuItem(
          id: 'm10',
          restaurantId: '5',
          name: 'Vegetable Curry',
          price: 10.99,
          imageUrl:
              'https://vikalinka.com/wp-content/uploads/2018/04/Butter-Chicken-Curry-1-Edit.jpg',
          category: 'Curries'),
    ];
    return allItems.where((item) => item.restaurantId == restaurantId).toList();
  }
}
