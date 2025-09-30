import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_ordering_app/core/error/failures.dart';
import 'package:food_ordering_app/data/models/cart_item.dart';
import 'package:food_ordering_app/data/models/menu_item.dart';
import 'package:food_ordering_app/data/models/order.dart';
import 'package:food_ordering_app/data/repositories/mock_order_repository.dart' as repo;
import 'package:food_ordering_app/presentation/bloc/order/order_bloc.dart';
import 'package:food_ordering_app/presentation/bloc/order/order_event.dart';
import 'package:food_ordering_app/presentation/bloc/order/order_state.dart';
import 'package:mockito/mockito.dart';
import 'mocks.dart';
import 'mocks.mocks.dart';

void main() {
  late MockOrderRepository mockRepo;
  late OrderBloc bloc;

  setUp(() {
    mockRepo = MockOrderRepository();
    bloc = OrderBloc(mockRepo);
  });

  tearDown(() {
    bloc.close();
  });

  const menuItem = MenuItem(
    id: 'm1',
    restaurantId: '1',
    name: 'Margherita Pizza',
    price: 12.99,
    imageUrl: 'https://via.placeholder.com/150',
    category: 'Pizza',
  );

  const cartItem = CartItem(menuItem: menuItem, quantity: 1);

  const order = Order(
    id: 'ORD123',
    items: [cartItem],
    total: 12.99, 
    status: 'Confirmed',
  );

  group('OrderBloc', () {
    test('initial state is OrderInitial', () {
      expect(bloc.state, OrderInitial());
    });

    blocTest<OrderBloc, OrderState>(
      'emits [OrderLoading, CartLoaded] when AddToCart succeeds',
      build: () {
        when(mockRepo.addToCart(any)).thenAnswer((_) async => Future.value());
        when(mockRepo.getCart()).thenAnswer((_) async => [cartItem]);
        return bloc;
      },
      act: (bloc) => bloc.add(const AddToCart(menuItem, 1)),
      expect: () => [
        OrderLoading(),
        CartLoaded([cartItem]),
      ],
    );

    blocTest<OrderBloc, OrderState>(
      'emits [OrderLoading, OrderError] when AddToCart fails',
      build: () {
        when(mockRepo.addToCart(any)).thenThrow(ValidationFailure('Invalid quantity'));
        return bloc;
      },
      act: (bloc) => bloc.add(const AddToCart(menuItem, 0)),
      expect: () => [
        OrderLoading(),
        isA<OrderError>().having((e) => e.failure, 'failure', isA<ValidationFailure>()),
      ],
    );

    blocTest<OrderBloc, OrderState>(
      'emits [OrderLoading, CartLoaded, OrderLoading, OrderPlaced] when PlaceOrder succeeds',
      build: () {
        when(mockRepo.addToCart(any)).thenAnswer((_) async => Future.value());
        when(mockRepo.getCart()).thenAnswer((_) async => [cartItem]);
        when(mockRepo.placeOrder(any)).thenAnswer((_) async => order);
        when(mockRepo.clearCart()).thenAnswer((_) async => Future.value());
        return bloc;
      },
      act: (bloc) async {
        bloc.add(const AddToCart(menuItem, 1));
        await Future.delayed(const Duration(milliseconds: 200));
        bloc.add(PlaceOrder());
      },
      expect: () => [
        OrderLoading(),
        CartLoaded([cartItem]),
        OrderLoading(),
        OrderPlaced(order),
      ],
    );

    blocTest<OrderBloc, OrderState>(
      'emits [OrderLoading, OrderError] when PlaceOrder fails with empty cart',
      build: () {
        when(mockRepo.getCart()).thenAnswer((_) async => <CartItem>[]);
        return bloc;
      },
      act: (bloc) => bloc.add(PlaceOrder()),
      expect: () => [
        OrderLoading(),
        isA<OrderError>().having((e) => e.failure, 'failure', isA<ValidationFailure>()),
      ],
    );

    blocTest<OrderBloc, OrderState>(
      'emits [OrderLoading, CartLoaded, OrderLoading, CartLoaded] when RemoveFromCart succeeds',
      build: () {
        int callCount = 0;
        when(mockRepo.addToCart(any)).thenAnswer((_) async => Future.value());
        when(mockRepo.getCart()).thenAnswer((_) async {
          callCount++;
          return callCount == 1 ? [cartItem] : <CartItem>[];
        });
        return bloc;
      },
      act: (bloc) async {
        bloc.add(const AddToCart(menuItem, 1));
        await Future.delayed(const Duration(milliseconds: 200));
        bloc.add(const RemoveFromCart('m1'));
      },
      expect: () => [
        OrderLoading(),
        CartLoaded([cartItem]),
        OrderLoading(),
        CartLoaded([]),
      ],
    );
  });
}