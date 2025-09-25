import '../models/cart_item.dart';
import '../models/order.dart';

abstract class OrderRepository {
  Future<void> addToCart(CartItem item);
  Future<List<CartItem>> getCart();
  Future<void> clearCart();
  Future<Order> placeOrder(List<CartItem> items);
}