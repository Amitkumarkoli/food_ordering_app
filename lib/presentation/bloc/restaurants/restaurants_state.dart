import 'package:equatable/equatable.dart';
import '../../../data/models/restaurant.dart';
import '../../../core/error/failures.dart';

abstract class RestaurantsState extends Equatable {
  const RestaurantsState();

  @override
  List<Object> get props => [];
}

class RestaurantsInitial extends RestaurantsState {}

class RestaurantsLoading extends RestaurantsState {}

class RestaurantsLoaded extends RestaurantsState {
  final List<Restaurant> restaurants;

  const RestaurantsLoaded(this.restaurants);

  @override
  List<Object> get props => [restaurants];
}

class RestaurantsError extends RestaurantsState {
  final Failure failure;

  const RestaurantsError(this.failure);

  @override
  List<Object> get props => [failure];
}