import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/core/error/failures.dart';
import '../../../data/repositories/restaurant_repository.dart';
import 'restaurants_event.dart';
import 'restaurants_state.dart';

class RestaurantsBloc extends Bloc<RestaurantsEvent, RestaurantsState> {
  final RestaurantRepository repository;

  RestaurantsBloc(this.repository) : super(RestaurantsInitial()) {
    on<LoadRestaurants>(_onLoadRestaurants);
    on<RetryLoadRestaurants>(_onLoadRestaurants);
  }

  Future<void> _onLoadRestaurants(RestaurantsEvent event, Emitter<RestaurantsState> emit) async {
    emit(RestaurantsLoading());
    try {
      final restaurants = await repository.getRestaurants();
      emit(RestaurantsLoaded(restaurants));
    } catch (e) {
      emit(RestaurantsError(e is Failure ? e : ServerFailure()));
    }
  }
}