import 'package:flutter/cupertino.dart' show CupertinoPage;
import 'package:go_router/go_router.dart';

import '/config/_config.dart' show scaleDownTransitionPage;
import '/features/_features.dart'
    show
        NoInternetConnectionScreen,
        SplashScreen,
        OnboardingScreen,
        WelcomeScreen;

final staticRoutes = [
  GoRoute(
    path: NoInternetConnectionScreen.routeName,
    name: NoInternetConnectionScreen.name,
    builder: (context, state) {
      return const NoInternetConnectionScreen();
    },
  ),
  GoRoute(
    path: SplashScreen.routeName,
    name: SplashScreen.name,
    pageBuilder: (context, state) => const CupertinoPage(child: SplashScreen()),
  ),
  GoRoute(
    path: WelcomeScreen.routeName,
    name: WelcomeScreen.name,
    pageBuilder: (context, state) {
      return scaleDownTransitionPage(context, state, const WelcomeScreen());
    },
  ),
  GoRoute(
    path: OnboardingScreen.routeName,
    name: OnboardingScreen.name,
    pageBuilder:
        (context, state) =>
            scaleDownTransitionPage(context, state, const OnboardingScreen()),
  ),
];
