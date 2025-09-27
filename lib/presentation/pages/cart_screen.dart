import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/presentation/bloc/order/order_bloc.dart';
import 'package:food_ordering_app/presentation/bloc/order/order_event.dart';
import 'package:food_ordering_app/presentation/bloc/order/order_state.dart';
import '../widgets/cart_item_tile.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            if (state.cartItems.isEmpty) {
              return const Center(child: Text('Your cart is empty'));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = state.cartItems[index];
                      return CartItemTile(
                        cartItem: item,
                        onRemove: () => context
                            .read<OrderBloc>()
                            .add(RemoveFromCart(item.menuItem.id)),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('Total: \$${state.total.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: state.cartItems.isNotEmpty
                            ? () => context.read<OrderBloc>().add(PlaceOrder())
                            : null,
                        child: const Text('Place Order'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is OrderError) {
            return Center(child: Text('Error: ${state.failure.message}'));
          }
          return const Center(child: Text('Cart unavailable'));
        },
      ),
    );
  }
}
