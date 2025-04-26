import 'package:flutter/material.dart';

class AdminProductScreen extends StatelessWidget {
  static const String routeName = '/admin/product';
  static const String name = 'Admin Product';
  const AdminProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Admin Product')));
  }
}
