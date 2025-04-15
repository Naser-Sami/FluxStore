import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/_core.dart' show ApiEndpoints;
import '/features/_features.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';
  static const String name = 'Splash';
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    if (ApiEndpoints.token != null) {
      if (mounted) {
        context.go(HomeScreen.routeName);
      }
    } else {
      if (mounted) {
        context.go(WelcomeScreen.routeName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
