import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const FoodOrderingApp());
}

class FoodOrderingApp extends StatelessWidget {
  const FoodOrderingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Ordering App',
      theme: appTheme,
      home: Scaffold(
        appBar: AppBar(title: Text('Food Ordering')),
        body: Center(child: Text('Workflow Placeholder')),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
