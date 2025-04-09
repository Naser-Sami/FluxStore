import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  static const String name = 'Profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Profile')));
  }
}
