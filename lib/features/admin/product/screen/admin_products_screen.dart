import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/features/admin/_admin.dart'
    show AdminAddProductScreen, AdminProductsScreenBodyWidget;

class AdminProductsScreen extends StatelessWidget {
  static const routeName = '/admin-products';
  static const name = 'Admin Products';
  const AdminProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Admin Body
      body: const AdminProductsScreenBodyWidget(),

      // Add Product Button
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddProductScreen(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  // Navigate to the Add Product Screen Function
  void _navigateToAddProductScreen(BuildContext context) => context.push(
    AdminProductsScreen.routeName + AdminAddProductScreen.routeName,
    extra: {'productId': null},
  );
}
