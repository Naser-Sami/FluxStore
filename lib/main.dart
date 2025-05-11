import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/_core.dart' show IServiceInitializer, ServiceInitializer;
import 'config/app/app.dart';
import 'config/bloc/bloc_providers.dart' show providers;

Future<void> main() async {
  IServiceInitializer serviceInitializer = ServiceInitializer();
  await serviceInitializer.init();

  runApp(MultiBlocProvider(providers: providers, child: const MyApp()));
}

//
// Easy Localization Generated Commands
// dart run easy_localization:generate --source-dir ./assets/translations
// dart run easy_localization:generate --source-dir ./assets/translations -f keys -o locale_keys.g.dart
