import 'package:flutter/material.dart';
import 'package:flux_store/core/services/di/di.dart';
import 'package:flux_store/features/_features.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  static const String name = 'Home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = sl<UserSessionCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
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
      body: Center(
        child: Column(
          children: [
            Text(user?.username ?? ""),
            Text(user?.email ?? ""),
            Text(user?.role == 0 ? "User" : "Admin"),
          ],
        ),
      ),
    );
  }
}
