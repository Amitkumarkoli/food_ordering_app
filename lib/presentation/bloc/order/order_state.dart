import 'package:equatable/equatable.dart';
import 'package:food_ordering_app/core/error/failures.dart';
import 'package:food_ordering_app/data/models/cart_item.dart';
import 'package:food_ordering_app/data/models/order.dart';

abstract class OrderState extends Equatable {
  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class CartLoaded extends OrderState {
  final List<CartItem> cartItems;

  CartLoaded(this.cartItems);

  @override
  List<Object> get props => [cartItems];
}

class OrderPlaced extends OrderState {
  final Order order;

  OrderPlaced(this.order);

  @override
  List<Object> get props => [order];
}

class OrderError extends OrderState {
  final Failure failure;

  OrderError(this.failure);

  @override
  List<Object> get props => [failure];
}