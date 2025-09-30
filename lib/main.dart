import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/core/services/notification_service.dart';
import 'package:food_ordering_app/data/repositories/mock_menu_repository.dart';
import 'package:food_ordering_app/data/repositories/mock_order_repository.dart';
import 'package:food_ordering_app/data/repositories/mock_restaurant_repository.dart';
import 'package:food_ordering_app/presentation/bloc/menu/menu_bloc.dart';
import 'package:food_ordering_app/presentation/bloc/order/order_bloc.dart';
import 'package:food_ordering_app/presentation/bloc/order/order_event.dart';
import 'package:food_ordering_app/presentation/bloc/restaurants/restaurants_bloc.dart';
import 'package:food_ordering_app/presentation/bloc/restaurants/restaurants_event.dart';
import 'package:food_ordering_app/presentation/pages/cart_screen.dart';
import 'package:food_ordering_app/presentation/pages/home_screen.dart';
import 'package:food_ordering_app/presentation/pages/menu_screen.dart';
import 'package:food_ordering_app/presentation/pages/order_confirmation_screen.dart';
import 'package:food_ordering_app/core/theme/app_theme.dart';

void main() {
  runApp(const FoodOrderingApp());
}

class FoodOrderingApp extends StatelessWidget {
  const FoodOrderingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider(create: (_) => MockRestaurantRepository()),
        RepositoryProvider(create: (_) => MockMenuRepository()),
        RepositoryProvider(create: (_) => MockOrderRepository()),
        BlocProvider(
          create: (context) => RestaurantsBloc(context.read<MockRestaurantRepository>())
            ..add(LoadRestaurants()),
        ),
        BlocProvider(
          create: (context) => MenuBloc(context.read<MockMenuRepository>()),
        ),
        BlocProvider(
          create: (context) => OrderBloc(context.read<MockOrderRepository>())..add(LoadCart()),
        ),
      ],
      child: MaterialApp(
        title: 'Food Ordering App',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/menu': (context) => const MenuScreen(),
          '/cart': (context) => const CartScreen(),
          '/order': (context) => const OrderConfirmationScreen(),
        },
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: NotificationService.scaffoldMessengerKey,
      ),
    );
  }
}