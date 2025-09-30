import 'package:food_ordering_app/data/models/menu_item.dart';
import 'package:food_ordering_app/data/repositories/menu_repository.dart';

class MenuRepositoryImpl implements MenuRepository {
  @override
  Future<List<MenuItem>> getMenuItems(String restaurantId) async {
    // Multiple menu items with real image URLs for visual appeal
    final menuItems = <MenuItem>[];
    if (restaurantId == '1') { // Pizza Palace
      menuItems.addAll([
        const MenuItem(
          id: 'm1',
          restaurantId: '1',
          name: 'Margherita Pizza',
          price: 12.99,
          imageUrl: 'https://www.pexels.com/photo/708587/download/', // Real pizza image from Pexels
          category: 'Pizza',
        ),
        const MenuItem(
          id: 'm2',
          restaurantId: '1',
          name: 'Pepperoni Pizza',
          price: 14.99,
          imageUrl: 'https://www.pexels.com/photo/315755/download/', // Real pepperoni pizza image from Pexels
          category: 'Pizza',
        ),
        const MenuItem(
          id: 'm3',
          restaurantId: '1',
          name: 'Vegetarian Pizza',
          price: 13.99,
          imageUrl: 'https://www.pexels.com/photo/803290/download/', // Real vegetarian pizza image from Pexels
          category: 'Pizza',
        ),
      ]);
    } else if (restaurantId == '2') { // Sushi Spot
      menuItems.addAll([
        const MenuItem(
          id: 'm4',
          restaurantId: '2',
          name: 'California Roll',
          price: 10.99,
          imageUrl: 'https://www.pexels.com/photo/2098085/download/', // Real sushi image from Pexels
          category: 'Sushi',
        ),
        const MenuItem(
          id: 'm5',
          restaurantId: '2',
          name: 'Spicy Tuna Roll',
          price: 12.99,
          imageUrl: 'https://www.pexels.com/photo/1597845/download/', // Real tuna sushi image from Pexels
          category: 'Sushi',
        ),
      ]);
    } else if (restaurantId == '3') { // Burger Bonanza
      menuItems.addAll([
        const MenuItem(
          id: 'm6',
          restaurantId: '3',
          name: 'Classic Burger',
          price: 9.99,
          imageUrl: 'https://www.pexels.com/photo/1639562/download/', // Real burger image from Pexels
          category: 'Burgers',
        ),
        const MenuItem(
          id: 'm7',
          restaurantId: '3',
          name: 'Cheese Burger',
          price: 10.99,
          imageUrl: 'https://www.pexels.com/photo/1639557/download/', // Real cheese burger image from Pexels
          category: 'Burgers',
        ),
      ]);
    } else if (restaurantId == '4') { // Taco Haven
      menuItems.addAll([
        const MenuItem(
          id: 'm8',
          restaurantId: '4',
          name: 'Chicken Taco',
          price: 8.99,
          imageUrl: 'https://www.pexels.com/photo/461198/download/', // Real taco image from Pexels
          category: 'Tacos',
        ),
        const MenuItem(
          id: 'm9',
          restaurantId: '4',
          name: 'Beef Taco',
          price: 9.99,
          imageUrl: 'https://www.pexels.com/photo/461199/download/', // Real beef taco image from Pexels
          category: 'Tacos',
        ),
      ]);
    } else if (restaurantId == '5') { // Curry Corner
      menuItems.addAll([
        const MenuItem(
          id: 'm10',
          restaurantId: '5',
          name: 'Butter Chicken',
          price: 11.99,
          imageUrl: 'https://www.pexels.com/photo/674574/download/', // Real curry image from Pexels
          category: 'Curries',
        ),
        const MenuItem(
          id: 'm11',
          restaurantId: '5',
          name: 'Vegetable Curry',
          price: 10.99,
          imageUrl: 'https://www.pexels.com/photo/674578/download/', // Real vegetable curry image from Pexels
          category: 'Curries',
        ),
      ]);
    }
    return menuItems;
  }
}