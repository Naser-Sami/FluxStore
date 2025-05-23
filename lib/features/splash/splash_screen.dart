import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/_core.dart' show AuthService, Constants, SecureStorageService, sl;
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
    final token = await sl<SecureStorageService>().read(
      key: Constants.keyAccessToken,
    );
    final refreshToken = await sl<SecureStorageService>().read(
      key: Constants.keyRefreshToken,
    );
    print("🔑 Token: $token");

    if (token != null && refreshToken != null) {
      final user = await sl<AuthService>().tryRefreshToken(token, refreshToken);

      if (user != null) {
        print("🔑 User: $user");
        if (user.role.toLowerCase() == 'admin') {
          if (mounted) context.go(AdminCategoryScreen.routeName);
          return;
        }
        if (mounted) context.go(HomeScreen.routeName);
        return;
      }
    }
    if (mounted) context.go(WelcomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
