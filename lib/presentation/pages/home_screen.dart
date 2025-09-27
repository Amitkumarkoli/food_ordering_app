import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/presentation/bloc/menu/menu_bloc.dart';
import 'package:food_ordering_app/presentation/bloc/menu/menu_event.dart';
import 'package:food_ordering_app/presentation/bloc/restaurants/restaurants_bloc.dart';
import 'package:food_ordering_app/presentation/bloc/restaurants/restaurants_event.dart';
import 'package:food_ordering_app/presentation/bloc/restaurants/restaurants_state.dart';
import '../widgets/restaurant_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Local Restaurants')),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: BlocBuilder<RestaurantsBloc, RestaurantsState>(
          builder: (context, state) {
            if (state is RestaurantsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RestaurantsLoaded) {
              return ListView.builder(
                itemCount: state.restaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = state.restaurants[index];
                  return RestaurantCard(
                    restaurant: restaurant,
                    onTap: () {
                      context.read<MenuBloc>().add(LoadMenu(restaurant.id));
                      Navigator.pushNamed(context, '/menu',
                          arguments: restaurant.id);
                    },
                  );
                },
              );
            } else if (state is RestaurantsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${state.failure.message}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context
                          .read<RestaurantsBloc>()
                          .add(RetryLoadRestaurants()),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: Text('No restaurants available'));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/cart'),
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
