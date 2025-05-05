import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/app.dart';
import '/core/_core.dart' show IServiceInitializer, ServiceInitializer;
import 'config/bloc/bloc_providers.dart' show providers;

Future<void> main() async {
  IServiceInitializer serviceInitializer = ServiceInitializer();
  await serviceInitializer.init();

  // Get All Products Api is shared with filter in many screens

  // so we need to cache the data
  // and we need to use the cached data if available
  // otherwise we need to fetch the data from the api

  // OR
  // We need to create separate api for filter and other cases
  // Like: Featured Products, New Arrivals, Best Sellers, etc.

  runApp(MultiBlocProvider(providers: providers, child: const MyApp()));
}

// Easy Localization Generated Commands
// flutter pub run easy_localization:generate --source-dir ./assets/translations
// flutter pub run easy_localization:generate --source-dir ./assets/translations -f keys -o locale_keys.g.dart

// dart run easy_localization:generate --source-dir ./assets/translations
// dart run easy_localization:generate --source-dir ./assets/translations -f keys -o locale_keys.g.dart
