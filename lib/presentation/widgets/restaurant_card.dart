import 'package:flutter/material.dart';
import '../../data/models/restaurant.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final VoidCallback onTap;

  const RestaurantCard({super.key, required this.restaurant, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Hero(
        tag: 'restaurant-${restaurant.id}',
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              restaurant.imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.error),
            ),
          ),
          title: Text(restaurant.name, style: Theme.of(context).textTheme.titleMedium),
          subtitle: Text('${restaurant.cuisine} • ${restaurant.rating} ★ • ${restaurant.deliveryTimeMinutes} min'),
          trailing: const Icon(Icons.arrow_forward),
          onTap: onTap,
        ),
      ),
    );
  }
}