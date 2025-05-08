import 'package:go_router/go_router.dart';

import '/config/_config.dart';
import '/core/_core.dart';
import '/features/_features.dart';
import '_app_redirect.dart';
import '_error_builder.dart';
import 'app_routes/_app_routes.dart';

export 'config/navigate_transitions.dart';
export 'config/navigator_observer.dart';

final router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: SplashScreen.routeName,
  debugLogDiagnostics: true,
  observers: [AppNavigatorObserver()],
  errorBuilder: errorBuilder,
  redirect: appRedirectLogic,
  routes: appRoutes,
);
