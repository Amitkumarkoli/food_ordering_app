import 'package:equatable/equatable.dart';
import 'cart_item.dart';

class Order extends Equatable {
  final String id;
  final List<CartItem> items;
  final double total;
  final String status; // e.g., 'pending', 'confirmed'

  const Order({
    required this.id,
    required this.items,
    required this.total,
    required this.status,
  });

  @override
  List<Object> get props => [id, items, total, status];
}