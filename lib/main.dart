import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'config/_config.dart' show providers;
import 'core/_core.dart' show IServiceInitializer, ServiceInitializer;

Future<void> main() async {
  IServiceInitializer serviceInitializer = ServiceInitializer();
  await serviceInitializer.init();

  runApp(MultiBlocProvider(providers: providers, child: const MyApp()));
}


// Easy Localization Generated Commands
// flutter pub run easy_localization:generate --source-dir ./assets/translations
// flutter pub run easy_localization:generate --source-dir ./assets/translations -f keys -o locale_keys.g.dart

// dart run easy_localization:generate --source-dir ./assets/translations
// dart run easy_localization:generate --source-dir ./assets/translations -f keys -o locale_keys.g.dart