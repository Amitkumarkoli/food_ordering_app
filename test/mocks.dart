import 'package:food_ordering_app/data/repositories/restaurant_repository.dart';
import 'package:food_ordering_app/data/repositories/menu_repository.dart';
import 'package:food_ordering_app/data/repositories/order_repository.dart';
import 'package:food_ordering_app/presentation/bloc/menu/menu_bloc.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([RestaurantRepository, MenuRepository, OrderRepository, MenuBloc])
void main() {}