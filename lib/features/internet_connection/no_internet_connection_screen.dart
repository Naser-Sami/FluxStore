import 'package:flutter/material.dart';

class NoInternetConnectionScreen extends StatelessWidget {
  static const String routeName = '/no-internet';
  static const String name = 'No Internet Connection';
  const NoInternetConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off, size: 80, color: Colors.red),
              SizedBox(height: 10),
              Text('No Internet Connection'),
            ],
          ),
        ),
      ),
    );
  }
}
