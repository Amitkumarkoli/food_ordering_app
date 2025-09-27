import 'package:flutter/material.dart';
import '../../data/models/menu_item.dart';

class MenuItemTile extends StatelessWidget {
  final MenuItem menuItem;
  final ValueChanged<int> onQuantityChanged;

  const MenuItemTile({super.key, required this.menuItem, required this.onQuantityChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            menuItem.imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.error),
          ),
        ),
        title: Text(menuItem.name, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text('\$${menuItem.price.toStringAsFixed(2)} • ${menuItem.category}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () => onQuantityChanged(-1),
            ),
            const Text('0'), // Placeholder; update with state in UI
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => onQuantityChanged(1),
            ),
          ],
        ),
      ),
    );
  }
}