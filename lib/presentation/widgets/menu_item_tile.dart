import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/data/models/menu_item.dart';
import 'package:food_ordering_app/core/services/notification_service.dart';
import 'package:food_ordering_app/presentation/bloc/order/order_bloc.dart';
import 'package:food_ordering_app/presentation/bloc/order/order_event.dart';

class MenuItemTile extends StatefulWidget {
  final MenuItem menuItem;
  final ValueChanged<int> onQuantityChanged;

  const MenuItemTile(
      {super.key, required this.menuItem, required this.onQuantityChanged});

  @override
  State<MenuItemTile> createState() => _MenuItemTileState();
}

class _MenuItemTileState extends State<MenuItemTile> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            widget.menuItem.imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.error),
          ),
        ),
        title: Text(widget.menuItem.name,
            style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(
            '\$${widget.menuItem.price.toStringAsFixed(2)} • ${widget.menuItem.category}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                if (_quantity > 1) {
                  setState(() {
                    _quantity--;
                  });
                  widget.onQuantityChanged(-1);
                }
              },
            ),
            Text('$_quantity'),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  _quantity++;
                });
                widget.onQuantityChanged(1);
              },
            ),
            IconButton(
              icon: const Icon(Icons.add_shopping_cart, color: Colors.green),
              onPressed: () {
                context
                    .read<OrderBloc>()
                    .add(AddToCart(widget.menuItem, _quantity));
                NotificationService.showSnackBar(
                    'Added $_quantity x ${widget.menuItem.name} to cart!');
                setState(() {
                  _quantity = 1; 
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
