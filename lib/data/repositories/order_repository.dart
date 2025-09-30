import 'package:food_ordering_app/data/models/cart_item.dart';
import 'package:food_ordering_app/data/models/order.dart';

abstract class OrderRepository {
  Future<void> addToCart(CartItem cartItem);
  Future<List<CartItem>> getCart();
  Future<void> clearCart();
  Future<Order> placeOrder(List<CartItem> cartItems);
}