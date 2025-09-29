import 'package:mockito/annotations.dart';
import 'package:food_ordering_app/data/repositories/restaurant_repository.dart';
import 'package:food_ordering_app/data/repositories/menu_repository.dart';
import 'package:food_ordering_app/data/repositories/order_repository.dart';

@GenerateMocks([RestaurantRepository, MenuRepository, OrderRepository])
void main() {}