import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/core/services/notification_service.dart';
import 'package:food_ordering_app/presentation/bloc/menu/menu_bloc.dart';
import 'package:food_ordering_app/presentation/bloc/menu/menu_event.dart';
import 'package:food_ordering_app/presentation/bloc/menu/menu_state.dart';
import 'package:food_ordering_app/presentation/bloc/order/order_bloc.dart';
import 'package:food_ordering_app/presentation/bloc/order/order_event.dart';

import '../widgets/menu_item_tile.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurantId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'restaurant-$restaurantId',
          child: Material(
            color: Colors.transparent,
            child: Text('Menu', style: Theme.of(context).textTheme.titleLarge),
          ),
        ),
      ),
      body: BlocListener<MenuBloc, MenuState>(
        listener: (context, state) {
          if (state is MenuLoaded) {
            NotificationService.showSnackBar('Menu loaded successfully!');
          } else if (state is MenuError) {
            NotificationService.showSnackBar('Error: ${state.failure.message}', isError: true);
          }
        },
        child: BlocBuilder<MenuBloc, MenuState>(
          builder: (context, state) {
            if (state is MenuLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MenuLoaded) {
              return ListView.builder(
                itemCount: state.menuItems.length,
                itemBuilder: (context, index) {
                  final item = state.menuItems[index];
                  return MenuItemTile(
                    menuItem: item,
                    onQuantityChanged: (delta) {
                      if (delta > 0) {
                        context.read<OrderBloc>().add(AddToCart(item, delta));
                      }
                    },
                  );
                },
              );
            } else if (state is MenuError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${state.failure.message}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context
                          .read<MenuBloc>()
                          .add(RetryLoadMenu(restaurantId)),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: Text('No menu available'));
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