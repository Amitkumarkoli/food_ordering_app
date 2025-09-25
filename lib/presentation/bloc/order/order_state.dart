import 'package:equatable/equatable.dart';
import '../../../data/models/cart_item.dart';
import '../../../data/models/order.dart';
import '../../../core/error/failures.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class CartLoaded extends OrderState {
  final List<CartItem> cartItems;
  final double total;

  CartLoaded(this.cartItems) : total = cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  @override
  List<Object> get props => [cartItems, total];
}

class OrderPlaced extends OrderState {
  final Order order;

  const OrderPlaced(this.order);

  @override
  List<Object> get props => [order];
}

class OrderError extends OrderState {
  final Failure failure;

  const OrderError(this.failure);

  @override
  List<Object> get props => [failure];
}