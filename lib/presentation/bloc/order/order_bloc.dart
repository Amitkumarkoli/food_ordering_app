import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/core/error/failures.dart';
import '../../../data/repositories/order_repository.dart';
import '../../../data/models/cart_item.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository repository;

  OrderBloc(this.repository) : super(OrderInitial()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<LoadCart>(_onLoadCart);
    on<PlaceOrder>(_onPlaceOrder);
    on<RetryPlaceOrder>(_onPlaceOrder);
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      await repository.addToCart(CartItem(menuItem: event.menuItem, quantity: event.quantity));
      final cartItems = await repository.getCart();
      emit(CartLoaded(cartItems));
    } catch (e) {
      emit(OrderError(e is Failure ? e : ServerFailure()));
    }
  }

  Future<void> _onRemoveFromCart(RemoveFromCart event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      final cartItems = await repository.getCart();
      final updatedCart = cartItems.where((item) => item.menuItem.id != event.menuItemId).toList();
      await repository.clearCart();
      for (final item in updatedCart) {
        await repository.addToCart(item);
      }
      emit(CartLoaded(updatedCart));
    } catch (e) {
      emit(OrderError(e is Failure ? e : ServerFailure()));
    }
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      final cartItems = await repository.getCart();
      emit(CartLoaded(cartItems));
    } catch (e) {
      emit(OrderError(e is Failure ? e : ServerFailure()));
    }
  }

  Future<void> _onPlaceOrder(OrderEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      final cartItems = await repository.getCart();
      final order = await repository.placeOrder(cartItems);
      emit(OrderPlaced(order));
    } catch (e) {
      emit(OrderError(e is Failure ? e : ServerFailure()));
    }
  }
}