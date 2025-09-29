import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_ordering_app/presentation/bloc/order/order_bloc.dart';
import 'package:food_ordering_app/presentation/bloc/order/order_event.dart';
import 'package:food_ordering_app/presentation/bloc/order/order_state.dart';
import 'package:mockito/mockito.dart';
import 'package:food_ordering_app/core/error/failures.dart';
import 'package:food_ordering_app/data/models/cart_item.dart';
import 'package:food_ordering_app/data/models/menu_item.dart';
import 'package:food_ordering_app/data/models/order.dart';
import 'mocks.dart';
import 'mocks.mocks.dart';

void main() {
  late MockOrderRepository mockRepo;
  late OrderBloc bloc;

  setUp(() {
    mockRepo = MockOrderRepository();
    bloc = OrderBloc(mockRepo);
  });

  const menuItem = MenuItem(
    id: 'm1',
    restaurantId: '1',
    name: 'Margherita Pizza',
    price: 12.99,
    imageUrl: '',
    category: 'Pizza',
  );
  const cartItem = CartItem(menuItem: menuItem, quantity: 1);
  const order =
      Order(id: 'ORD123', items: [cartItem], total: 12.99, status: 'confirmed');

  group('OrderBloc', () {
    blocTest<OrderBloc, OrderState>(
      'emits [Loading, CartLoaded] when AddToCart succeeds',
      build: () {
        when(mockRepo.addToCart(any)).thenAnswer((invocation) async {
          final item = invocation.positionalArguments[0] as CartItem?;
          print('Mock addToCart called with: $item');
          if (item == null) throw Exception('Received null CartItem');
        });
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
      'emits [Loading, Error] when AddToCart fails',
      build: () {
        when(mockRepo.addToCart(any)).thenAnswer((invocation) async {
          final item = invocation.positionalArguments[0] as CartItem?;
          print('Mock addToCart called with: $item');
          if (item == null) throw Exception('Received null CartItem');
          throw ValidationFailure('Invalid quantity');
        });
        return bloc;
      },
      act: (bloc) => bloc.add(const AddToCart(menuItem, 0)),
      expect: () => [OrderLoading(), isA<OrderError>()],
    );

    blocTest<OrderBloc, OrderState>(
      'emits [Loading, OrderPlaced] when PlaceOrder succeeds',
      build: () {
        when(mockRepo.getCart()).thenAnswer((_) async => [cartItem]);
        when(mockRepo.placeOrder(any)).thenAnswer((invocation) async {
          final items = invocation.positionalArguments[0] as List<CartItem>?;
          print('Mock placeOrder called with: $items');
          if (items == null) throw Exception('Received null List<CartItem>');
          return order;
        });
        return bloc;
      },
      act: (bloc) => bloc.add(PlaceOrder()),
      expect: () => [OrderLoading(), OrderPlaced(order)],
    );
  });
}
