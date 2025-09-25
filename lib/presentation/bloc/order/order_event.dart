import 'package:equatable/equatable.dart';
import '../../../data/models/cart_item.dart';
import '../../../data/models/menu_item.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class AddToCart extends OrderEvent {
  final MenuItem menuItem;
  final int quantity;

  const AddToCart(this.menuItem, this.quantity);

  @override
  List<Object> get props => [menuItem, quantity];
}

class RemoveFromCart extends OrderEvent {
  final String menuItemId;

  const RemoveFromCart(this.menuItemId);

  @override
  List<Object> get props => [menuItemId];
}

class LoadCart extends OrderEvent {}

class PlaceOrder extends OrderEvent {}

class RetryPlaceOrder extends OrderEvent {}