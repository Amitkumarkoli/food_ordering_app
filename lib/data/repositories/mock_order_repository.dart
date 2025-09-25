import 'dart:math';
import '../../core/error/failures.dart';
import '../models/cart_item.dart';
import '../models/order.dart';
import 'order_repository.dart';

class MockOrderRepository implements OrderRepository {
  final List<CartItem> _cart = [];

  @override
  Future<void> addToCart(CartItem item) async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (item.quantity <= 0) {
      throw ValidationFailure('Quantity must be greater than 0');
    }
    final existingIndex = _cart.indexWhere((ci) => ci.menuItem.id == item.menuItem.id);
    if (existingIndex >= 0) {
      _cart[existingIndex] = CartItem(
        menuItem: item.menuItem,
        quantity: _cart[existingIndex].quantity + item.quantity,
      );
    } else {
      _cart.add(item);
    }
  }

  @override
  Future<List<CartItem>> getCart() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.unmodifiable(_cart);
  }

  @override
  Future<void> clearCart() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _cart.clear();
  }

  @override
  Future<Order> placeOrder(List<CartItem> items) async {
    await Future.delayed(const Duration(seconds: 2));
    if (Random().nextInt(10) == 0) {
      throw ServerFailure();
    }
    if (items.isEmpty) {
      throw ValidationFailure('Cart is empty');
    }
    final total = items.fold(0.0, (sum, item) => sum + item.totalPrice);
    final orderId = 'ORD${DateTime.now().millisecondsSinceEpoch}';
    await clearCart();
    return Order(
      id: orderId,
      items: items,
      total: total,
      status: 'confirmed',
    );
  }
}