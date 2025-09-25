import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String cuisine;
  final double rating;
  final String imageUrl;
  final int deliveryTimeMinutes;

  const Restaurant({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.rating,
    required this.imageUrl,
    required this.deliveryTimeMinutes,
  });

  @override
  List<Object> get props => [id, name, cuisine, rating, imageUrl, deliveryTimeMinutes];
}