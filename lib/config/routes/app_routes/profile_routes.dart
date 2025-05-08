import 'package:flutter/cupertino.dart' show CupertinoPage;
import 'package:go_router/go_router.dart';

import '/features/profile/_profile.dart' show ProfileSettingsScreen;

final profileRoutes = [
  GoRoute(
    path: ProfileSettingsScreen.routeName,
    name: ProfileSettingsScreen.name,
    pageBuilder:
        (context, state) => const CupertinoPage(child: ProfileSettingsScreen()),
  ),
];
