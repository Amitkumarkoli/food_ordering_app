import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/core/services/notification_service.dart';
import 'package:food_ordering_app/presentation/bloc/order/order_bloc.dart';
import 'package:food_ordering_app/presentation/bloc/order/order_event.dart';
import 'package:food_ordering_app/presentation/bloc/order/order_state.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Confirmation')),
      body: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderPlaced) {
            NotificationService.showSnackBar('Order placed successfully!');
          } else if (state is OrderError) {
            NotificationService.showSnackBar('Error: ${state.failure.message}', isError: true);
          }
        },
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OrderPlaced) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green, size: 80),
                    const SizedBox(height: 16),
                    Text(
                      'Order Placed!',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text('Order ID: ${state.order.id}'),
                    Text('Total: \$${state.order.total.toStringAsFixed(2)}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                      child: const Text('Back to Home'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: Size(200, 50),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is OrderError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, color: Colors.red, size: 80),
                    const SizedBox(height: 16),
                    Text('Error: ${state.failure.message}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<OrderBloc>().add(RetryPlaceOrder()),
                      child: const Text('Retry'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        minimumSize: Size(200, 50),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: Text('No order status'));
          },
        ),
      ),
    );
  }
}