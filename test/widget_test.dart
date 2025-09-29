import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/core/services/notification_service.dart';
import 'package:food_ordering_app/data/models/restaurant.dart';
import 'package:food_ordering_app/data/models/menu_item.dart';
import 'package:food_ordering_app/data/repositories/menu_repository_impl.dart';
import 'package:food_ordering_app/data/repositories/restaurant_repository_impl.dart';
import 'package:food_ordering_app/presentation/bloc/restaurants/restaurants_bloc.dart';
import 'package:food_ordering_app/presentation/bloc/restaurants/restaurants_event.dart';
import 'package:food_ordering_app/presentation/pages/home_screen.dart';
import 'package:food_ordering_app/presentation/pages/menu_screen.dart';
import 'package:mockito/mockito.dart';
import 'mocks.dart';
import 'mocks.mocks.dart';

void main() {
  late MockRestaurantRepository mockRestaurantRepo;
  late MockMenuRepository mockMenuRepo;
  late RestaurantsBloc restaurantsBloc;

  setUp(() {
    mockRestaurantRepo = MockRestaurantRepository();
    mockMenuRepo = MockMenuRepository();
    restaurantsBloc = RestaurantsBloc(mockRestaurantRepo);
  });

  const restaurant = Restaurant(
    id: '1',
    name: 'Pizza Palace',
    cuisine: 'Italian',
    rating: 4.5,
    imageUrl: '',
    deliveryTimeMinutes: 30,
  );

  const menuItem = MenuItem(
    id: 'm1',
    restaurantId: '1',
    name: 'Margherita Pizza',
    price: 12.99,
    imageUrl: '',
    category: 'Pizza',
  );

  testWidgets('HomeScreen shows SnackBar and navigates to MenuScreen',
      (WidgetTester tester) async {
    when(mockRestaurantRepo.getRestaurants())
        .thenAnswer((_) async => [restaurant]);
    when(mockMenuRepo.getMenuItems('1')).thenAnswer((_) async => [menuItem]);

    await tester.pumpWidget(
      MaterialApp(
        home: ScaffoldMessenger(
          key: NotificationService.scaffoldMessengerKey,
          child: RepositoryProvider(
            create: (context) => mockRestaurantRepo,
            child: BlocProvider(
              create: (context) => restaurantsBloc..add(LoadRestaurants()),
              child: HomeScreen(),
            ),
          ),
        ),
      ),
    );

    await tester.pump(Duration(seconds: 1)); // Wait for SnackBar
    expect(find.text('Restaurants loaded successfully!'), findsOneWidget);

    await tester.tap(find.text('Pizza Palace'));
    await tester.pumpAndSettle();

    expect(find.byType(MenuScreen), findsOneWidget);
    expect(find.text('Margherita Pizza'), findsOneWidget);
    await tester.pump(Duration(seconds: 1)); // Wait for MenuScreen SnackBar
    expect(find.text('Menu loaded successfully!'), findsOneWidget);
  });
}
