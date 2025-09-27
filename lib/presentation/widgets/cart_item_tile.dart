import 'package:flutter/material.dart';
import '../../data/models/cart_item.dart';

class CartItemTile extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onRemove;

  const CartItemTile({super.key, required this.cartItem, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          cartItem.menuItem.imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Icon(Icons.error),
        ),
      ),
      title: Text(cartItem.menuItem.name),
      subtitle: Text('Qty: ${cartItem.quantity} • \$${cartItem.totalPrice.toStringAsFixed(2)}'),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: onRemove,
      ),
    );
  }
}