import 'package:bloc/bloc.dart';
import 'package:food_ordering_app/core/error/failures.dart';
import 'package:food_ordering_app/data/models/cart_item.dart';
import 'package:food_ordering_app/data/models/menu_item.dart';
import 'package:food_ordering_app/data/models/order.dart';
import 'package:food_ordering_app/data/repositories/order_repository.dart';
import 'package:food_ordering_app/presentation/bloc/order/order_event.dart';
import 'package:food_ordering_app/presentation/bloc/order/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;
  List<CartItem> _cartItems = [];

  OrderBloc(this.orderRepository) : super(OrderInitial()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<LoadCart>(_onLoadCart);
    on<PlaceOrder>(_onPlaceOrder);
    on<RetryPlaceOrder>(_onRetryPlaceOrder);
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      final cartItem = CartItem(menuItem: event.menuItem, quantity: event.quantity);
      await orderRepository.addToCart(cartItem);
      final existingIndex = _cartItems.indexWhere((item) => item.menuItem.id == event.menuItem.id);
      if (existingIndex >= 0) {
        _cartItems[existingIndex] = CartItem(
          menuItem: event.menuItem,
          quantity: _cartItems[existingIndex].quantity + event.quantity,
        );
      } else {
        _cartItems = [..._cartItems, cartItem];
      }
      emit(CartLoaded(_cartItems));
    } catch (e) {
      emit(OrderError(e is Failure ? e : ServerFailure()));
    }
  }

  Future<void> _onRemoveFromCart(RemoveFromCart event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      _cartItems = _cartItems.where((item) => item.menuItem.id != event.menuItemId).toList();
      emit(CartLoaded(_cartItems));
    } catch (e) {
      emit(OrderError(e is Failure ? e : ServerFailure()));
    }
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      _cartItems = await orderRepository.getCart();
      emit(CartLoaded(_cartItems));
    } catch (e) {
      emit(OrderError(e is Failure ? e : ServerFailure()));
    }
  }

  Future<void> _onPlaceOrder(PlaceOrder event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      if (_cartItems.isEmpty) {
        emit(OrderError(ValidationFailure('Cart is empty')));
        return;
      }
      final order = await orderRepository.placeOrder(_cartItems);
      await orderRepository.clearCart();
      _cartItems = [];
      emit(OrderPlaced(order));
    } catch (e) {
      emit(OrderError(e is Failure ? e : ServerFailure()));
    }
  }

  Future<void> _onRetryPlaceOrder(RetryPlaceOrder event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      if (_cartItems.isEmpty) {
        emit(OrderError(ValidationFailure('Cart is empty')));
        return;
      }
      final order = await orderRepository.placeOrder(_cartItems);
      await orderRepository.clearCart();
      _cartItems = [];
      emit(OrderPlaced(order));
    } catch (e) {
      emit(OrderError(e is Failure ? e : ServerFailure()));
    }
  }
}