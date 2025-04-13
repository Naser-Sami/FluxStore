import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/_core.dart' show sl;
import '/features/_features.dart' show SplashScreen, UserSessionCubit;

class AdminDashboardScreen extends StatelessWidget {
  static const String routeName = '/admin/dashboard';
  static const String name = 'AdminDashboard';
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              sl<UserSessionCubit>().logout();
              context.go(SplashScreen.routeName);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(child: Text('Admin Dashboard')),
    );
  }
}
