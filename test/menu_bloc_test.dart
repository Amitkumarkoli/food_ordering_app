import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_ordering_app/presentation/bloc/menu/menu_bloc.dart';
import 'package:food_ordering_app/presentation/bloc/menu/menu_event.dart';
import 'package:food_ordering_app/presentation/bloc/menu/menu_state.dart';
import 'package:mockito/mockito.dart';
import 'package:food_ordering_app/core/error/failures.dart';
import 'package:food_ordering_app/data/models/menu_item.dart';
import 'mocks.dart';
import 'mocks.mocks.dart';

void main() {
  late MockMenuRepository mockRepo;
  late MenuBloc bloc;

  setUp(() {
    mockRepo = MockMenuRepository();
    bloc = MenuBloc(mockRepo);
  });

  const menuItem = MenuItem(
    id: 'm1',
    restaurantId: '1',
    name: 'Margherita Pizza',
    price: 12.99,
    imageUrl: '',
    category: 'Pizza',
  );

  group('MenuBloc', () {
    blocTest<MenuBloc, MenuState>(
      'emits [Loading, Loaded] when LoadMenu succeeds',
      build: () {
        when(mockRepo.getMenuItems('1')).thenAnswer((_) async {
          print('Mock getMenuItems called for LoadMenu');
          return [menuItem];
        });
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadMenu('1')),
      expect: () => [
        MenuLoading(),
        MenuLoaded([menuItem]),
      ],
    );

    blocTest<MenuBloc, MenuState>(
      'emits [Loading, Error] when LoadMenu fails',
      build: () {
        when(mockRepo.getMenuItems('1')).thenAnswer((_) async {
          print('Mock getMenuItems called for LoadMenu failure');
          throw ServerFailure();
        });
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadMenu('1')),
      expect: () => [
        MenuLoading(),
        isA<MenuError>(),
      ],
    );
  });
}