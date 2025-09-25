import '../models/menu_item.dart';

abstract class MenuRepository {
  Future<List<MenuItem>> getMenuItems(String restaurantId);
}