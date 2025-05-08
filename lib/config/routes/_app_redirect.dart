import 'package:flutter/material.dart' show BuildContext;
import 'package:go_router/go_router.dart';

import '/core/_core.dart' show AuthService, Constants, SecureStorageService, sl;
import '/features/_features.dart' show WelcomeScreen;

Future<String?> appRedirectLogic(
  BuildContext context,
  GoRouterState state,
) async {
  final token = await sl<SecureStorageService>().read(
    key: Constants.keyAccessToken,
  );
  final refreshToken = await sl<SecureStorageService>().read(
    key: Constants.keyRefreshToken,
  );

  if (token != null && refreshToken != null) {
    final user = await sl<AuthService>().tryRefreshToken(token, refreshToken);
    if (user != null) return null;
  }

  return WelcomeScreen.routeName;
}
