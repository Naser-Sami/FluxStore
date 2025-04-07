import 'package:flutter/material.dart';
import 'package:flux_store/core/services/di/di.dart';
import 'package:flux_store/features/_features.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  static const String name = 'Home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          children: [
            const Text('Home Screen'),
            Text(sl<LoginBloc>().state.toString()),
          ],
        ),
      ),
    );
  }
}
