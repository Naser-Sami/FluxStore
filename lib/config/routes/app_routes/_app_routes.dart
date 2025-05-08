// routes.dart
import 'package:go_router/go_router.dart';

import 'admin_routes.dart';
import 'auth_routes.dart';
import 'bottom_nav_routes.dart';
import 'products_routes.dart';
import 'profile_routes.dart';
import 'static_routes.dart';
import 'stocks_routes.dart';

final List<RouteBase> appRoutes = [
  ...authRoutes,
  ...adminRoutes,
  ...bottomNavRoutes,
  ...staticRoutes,
  ...profileRoutes,
  ...productsRoutes,
  ...stocksRoutes,
];
