import 'package:equatable/equatable.dart';
import 'menu_item.dart';

class CartItem extends Equatable {
  final MenuItem menuItem;
  final int quantity;

  const CartItem({
    required this.menuItem,
    required this.quantity,
  });

  double get totalPrice => menuItem.price * quantity;

  @override
  List<Object> get props => [menuItem, quantity];
}