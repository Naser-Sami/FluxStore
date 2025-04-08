import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  static const String name = 'Cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: const Center(child: Text('Cart')),
    );
  }
}
