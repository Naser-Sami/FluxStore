import 'package:flutter/cupertino.dart' show CupertinoPage;
import 'package:go_router/go_router.dart';

import '/features/_features.dart' show RealTimeStockWidget;

final stocksRoutes = [
  GoRoute(
    path: RealTimeStockWidget.routeName,
    name: RealTimeStockWidget.name,
    pageBuilder: (context, state) {
      return CupertinoPage(child: RealTimeStockWidget());
    },
  ),
];
