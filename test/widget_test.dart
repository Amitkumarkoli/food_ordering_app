// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:food_ordering_app/core/services/notification_service.dart';
// import 'package:food_ordering_app/data/models/restaurant.dart';
// import 'package:food_ordering_app/data/models/menu_item.dart';
// import 'package:food_ordering_app/data/repositories/mock_menu_repository.dart' as repo;
// import 'package:food_ordering_app/data/repositories/mock_restaurant_repository.dart' as repo;
// import 'package:food_ordering_app/presentation/bloc/menu/menu_bloc.dart';
// import 'package:food_ordering_app/presentation/bloc/menu/menu_event.dart';
// import 'package:food_ordering_app/presentation/bloc/menu/menu_state.dart';
// import 'package:food_ordering_app/presentation/bloc/restaurants/restaurants_bloc.dart';
// import 'package:food_ordering_app/presentation/bloc/restaurants/restaurants_event.dart';
// import 'package:food_ordering_app/presentation/bloc/restaurants/restaurants_state.dart';
// import 'package:food_ordering_app/presentation/pages/home_screen.dart';
// import 'package:food_ordering_app/presentation/pages/menu_screen.dart';
// import 'package:mockito/mockito.dart';
// import 'mocks.dart';
// import 'mocks.mocks.dart';

// void main() {
//   late MockRestaurantRepository mockRestaurantRepo;
//   late MockMenuRepository mockMenuRepo;
//   late MockMenuBloc menuBloc;
//   late StreamController<MenuState> menuStreamController;
//   late RestaurantsBloc restaurantsBloc;

//   setUp(() {
//     mockRestaurantRepo = MockRestaurantRepository();
//     mockMenuRepo = MockMenuRepository();
//     menuBloc = MockMenuBloc();
//     menuStreamController = StreamController<MenuState>.broadcast();
//     restaurantsBloc = RestaurantsBloc(mockRestaurantRepo);
//   });

//   tearDown(() {
//     menuStreamController.close();
//   });

//   const restaurant = Restaurant(
//     id: '1',
//     name: 'Pizza Palace',
//     cuisine: 'Italian',
//     rating: 4.5,
//     imageUrl: 'https://via.placeholder.com/150',
//     deliveryTimeMinutes: 30,
//   );

//   const menuItem = MenuItem(
//     id: 'm1',
//     restaurantId: '1',
//     name: 'Margherita Pizza',
//     price: 12.99,
//     imageUrl: 'https://via.placeholder.com/150',
//     category: 'Pizza',
//   );

//   testWidgets('HomeScreen shows SnackBar and navigates to MenuScreen', (WidgetTester tester) async {
//     when(mockRestaurantRepo.getRestaurants()).thenAnswer((_) async => [restaurant]);
//     when(mockMenuRepo.getMenuItems('1')).thenAnswer((_) async => [menuItem]);
//     when(menuBloc.stream).thenReturn(menuStreamController.stream);
//     when(menuBloc.state).thenReturn(MenuInitial());
//     when(menuBloc.add(LoadMenu('1'))).thenAnswer((_) async {
//       print('MockMenuBloc: LoadMenu("1") triggered, emitting MenuLoaded');
//       menuStreamController.add(MenuLoaded([menuItem]));
//     });
//     when(menuBloc.add(RetryLoadMenu('1'))).thenAnswer((_) async {
//       print('MockMenuBloc: RetryLoadMenu("1") triggered, emitting MenuLoaded');
//       menuStreamController.add(MenuLoaded([menuItem]));
//     });

//     await tester.runAsync(() async {
//       await tester.pumpWidget(
//         MaterialApp(
//           routes: {
//             '/menu': (context) => const MenuScreen(),
//           },
//           home: ScaffoldMessenger(
//             key: NotificationService.scaffoldMessengerKey,
//             child: Scaffold(
//               body: MultiBlocProvider(
//                 providers: [
//                   BlocProvider(create: (context) => restaurantsBloc),
//                   BlocProvider(create: (context) => menuBloc),
//                   RepositoryProvider(create: (context) => mockRestaurantRepo),
//                   RepositoryProvider(create: (context) => mockMenuRepo),
//                 ],
//                 child: const HomeScreen(),
//               ),
//             ),
//           ),
//         ),
//       );

//       // Debug: Check if HomeScreen is rendered
//       expect(find.text('Local Restaurants'), findsOneWidget);
//       expect(find.text('Pizza Palace'), findsOneWidget);

//       // Trigger RestaurantsBloc
//       restaurantsBloc.add(LoadRestaurants());
//       await tester.pump(const Duration(milliseconds: 100)); // Wait for Loading
//       await tester.pump(const Duration(seconds: 3)); // Wait for Loaded and SnackBar

//       expect(find.text('Restaurants loaded successfully!'), findsOneWidget);

//       // Simulate tapping Pizza Palace
//       await tester.tap(find.text('Pizza Palace'), warnIfMissed: true);
//       await tester.pump(); // Start navigation

//       // Trigger MenuBloc explicitly
//       print('Test: Triggering LoadMenu("1")');
//       menuBloc.add(LoadMenu('1'));
//       await tester.pump(const Duration(seconds: 3)); // Wait for MenuScreen SnackBar

//       expect(find.byType(MenuScreen), findsOneWidget);
//       expect(find.text('Margherita Pizza'), findsOneWidget);
//       expect(find.text('Menu loaded successfully!'), findsOneWidget);
//     });
//   });
// }

// // Mock MenuBloc for testing
// class MockMenuBloc extends Mock implements MenuBloc {
//   @override
//   void emit(MenuState state) {
//     super.noSuchMethod(
//       Invocation.method(#emit, [state]),
//       returnValue: null,
//       returnValueForMissingStub: null,
//     );
//   }
// }



































































































import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/core/services/notification_service.dart';
import 'package:food_ordering_app/data/models/restaurant.dart';
import 'package:food_ordering_app/data/models/menu_item.dart';
import 'package:food_ordering_app/data/repositories/mock_menu_repository.dart' as repo;
import 'package:food_ordering_app/data/repositories/mock_restaurant_repository.dart' as repo;
import 'package:food_ordering_app/presentation/bloc/menu/menu_bloc.dart';
import 'package:food_ordering_app/presentation/bloc/menu/menu_event.dart';
import 'package:food_ordering_app/presentation/bloc/menu/menu_state.dart';
import 'package:food_ordering_app/presentation/bloc/restaurants/restaurants_bloc.dart';
import 'package:food_ordering_app/presentation/bloc/restaurants/restaurants_event.dart';
import 'package:food_ordering_app/presentation/bloc/restaurants/restaurants_state.dart';
import 'package:food_ordering_app/presentation/pages/home_screen.dart';
import 'package:food_ordering_app/presentation/pages/menu_screen.dart';
import 'package:mockito/mockito.dart';
import 'mocks.dart';
import 'mocks.mocks.dart';

void main() {
  // Temporarily commented out 
  /*
  late MockRestaurantRepository mockRestaurantRepo;
  late MockMenuRepository mockMenuRepo;
  late MockMenuBloc menuBloc;
  late StreamController<MenuState> menuStreamController;
  late RestaurantsBloc restaurantsBloc;

  setUp(() {
    mockRestaurantRepo = MockRestaurantRepository();
    mockMenuRepo = MockMenuRepository();
    menuBloc = MockMenuBloc();
    menuStreamController = StreamController<MenuState>.broadcast();
    menuStreamController.add(MenuInitial());
    restaurantsBloc = RestaurantsBloc(mockRestaurantRepo);
  });

  tearDown(() {
    menuStreamController.close();
  });

  const restaurant = Restaurant(
    id: '1',
    name: 'Pizza Palace',
    cuisine: 'Italian',
    rating: 4.5,
    imageUrl: 'https://www.shutterstock.com/image-photo/covent-garden-london-united-kingdom-260nw-2378281951.jpg',
    deliveryTimeMinutes: 30,
  );

  const menuItem = MenuItem(
    id: 'm1',
    restaurantId: '1',
    name: 'Margherita Pizza',
    price: 12.99,
    imageUrl: 'https://media.istockphoto.com/id/1393150881/photo/italian-pizza-margherita-with-cheese-and-tomato-sauce-on-the-board-on-grey-table-macro-close.jpg?s=612x612&w=0&k=20&c=kL0Vhg2XKBjEl__iG8sFv31WTiahdpLc3rTDtNZuD2g=',
    category: 'Pizza',
  );

  testWidgets('HomeScreen shows SnackBar and navigates to MenuScreen', (WidgetTester tester) async {
    when(mockRestaurantRepo.getRestaurants()).thenAnswer((_) async => [restaurant]);
    when(mockMenuRepo.getMenuItems('1')).thenAnswer((_) async => [menuItem]);
    when(menuBloc.stream).thenReturn(menuStreamController.stream);
    when(menuBloc.state).thenReturn(MenuInitial());
    when(menuBloc.add(LoadMenu('1'))).thenAnswer((_) async {
      print('MockMenuBloc: LoadMenu("1") triggered, emitting MenuLoaded');
      menuStreamController.add(MenuLoaded([menuItem]));
    });
    when(menuBloc.add(RetryLoadMenu('1'))).thenAnswer((_) async {
      print('MockMenuBloc: RetryLoadMenu("1") triggered, emitting MenuLoaded');
      menuStreamController.add(MenuLoaded([menuItem]));
    });

    await tester.runAsync(() async {
      await tester.pumpWidget(
        MaterialApp(
          routes: {
            '/menu': (context) => const MenuScreen(),
          },
          home: ScaffoldMessenger(
            key: NotificationService.scaffoldMessengerKey,
            child: Scaffold(
              body: MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => restaurantsBloc),
                  BlocProvider(create: (context) => menuBloc),
                  RepositoryProvider(create: (context) => mockRestaurantRepo),
                  RepositoryProvider(create: (context) => mockMenuRepo),
                ],
                child: const HomeScreen(),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Local Restaurants'), findsOneWidget);
      expect(find.text('Pizza Palace'), findsOneWidget);

      restaurantsBloc.add(LoadRestaurants());
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(seconds: 3));

      expect(find.text('Restaurants loaded successfully!'), findsOneWidget);

      print('Test: Simulating tap on Pizza Palace');
      await tester.tap(find.text('Pizza Palace'), warnIfMissed: true);
      await tester.pumpAndSettle();

      verify(menuBloc.add(LoadMenu('1'))).called(1);
      print('Test: Triggering LoadMenu("1") explicitly');
      menuBloc.add(LoadMenu('1'));
      await tester.pump(const Duration(seconds: 3));

      expect(find.byType(MenuScreen), findsOneWidget);
      expect(find.text('Margherita Pizza'), findsOneWidget);
      expect(find.text('Menu loaded successfully!'), findsOneWidget);
    });
  });
  */
}

// Mock MenuBloc for testing
class MockMenuBloc extends Mock implements MenuBloc {
  @override
  void emit(MenuState state) {
    super.noSuchMethod(
      Invocation.method(#emit, [state]),
      returnValue: null,
      returnValueForMissingStub: null,
    );
  }
}