import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart' show ErrorPage;

Widget Function(BuildContext, GoRouterState)? errorBuilder = (context, state) {
  if (state.uri.path.contains('/link')) {}

  return ErrorPage(state.error.toString());
};
