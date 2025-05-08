import 'package:flutter/cupertino.dart' show CupertinoPage;
import 'package:go_router/go_router.dart';

import '/features/_features.dart' show ProductDetailsScreen, RateProductScreen;

final productsRoutes = [
  GoRoute(
    path: ProductDetailsScreen.routeName,
    name: ProductDetailsScreen.name,
    pageBuilder: (context, state) {
      final extra = state.extra as Map<String, dynamic>;
      final productId = extra['productId'];

      return CupertinoPage(child: ProductDetailsScreen(productId: productId));
    },
  ),
  GoRoute(
    path: RateProductScreen.routeName,
    name: RateProductScreen.name,
    pageBuilder: (context, state) {
      final extra = state.extra as Map<String, dynamic>;
      final productId = extra['productId'];

      return CupertinoPage(child: RateProductScreen(productId: productId));
    },
  ),
];
