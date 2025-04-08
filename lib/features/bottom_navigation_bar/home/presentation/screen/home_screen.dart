import 'package:flutter/material.dart';

import '/config/_config.dart' show TextWidget;
import '/core/_core.dart' show sl;
import '/features/_features.dart' show UserSessionCubit;

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  static const String name = 'Home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = sl<UserSessionCubit>().state;
    return Scaffold(
      // appBar: AppBar(title: const Text('Home')),
      body: Center(child: TextWidget('Welcome  ${user?.username}')),
    );
  }
}
