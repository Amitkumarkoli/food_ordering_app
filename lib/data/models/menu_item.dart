import 'package:equatable/equatable.dart';

class MenuItem extends Equatable {
  final String id;
  final String restaurantId;
  final String name;
  final double price;
  final String imageUrl;
  final String category;

  const MenuItem({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  @override
  List<Object> get props => [id, restaurantId, name, price, imageUrl, category];
}