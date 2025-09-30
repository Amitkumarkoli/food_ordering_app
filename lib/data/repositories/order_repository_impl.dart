import 'dart:math';
import 'package:food_ordering_app/data/models/cart_item.dart';
import 'package:food_ordering_app/data/models/order.dart';
import 'package:food_ordering_app/data/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  List<CartItem> _cart = [];

  @override
  Future<void> addToCart(CartItem item) async {
    await Future.delayed(Duration(milliseconds: 500));
    _cart.add(item);
  }

  @override
  Future<List<CartItem>> getCart() async {
    await Future.delayed(Duration(milliseconds: 500));
    return List.unmodifiable(_cart);
  }

  @override
  Future<void> clearCart() async {
    await Future.delayed(Duration(milliseconds: 500));
    _cart.clear();
  }

  @override
  Future<Order> placeOrder(List<CartItem> items) async {
    await Future.delayed(Duration(milliseconds: 500));
    final total = items.fold(0.0, (sum, item) => sum + item.menuItem.price * item.quantity);
    final order = Order(id: 'ORD${Random().nextInt(1000)}', items: items, total: total, status: '');
    clearCart();
    return order;
  }
}