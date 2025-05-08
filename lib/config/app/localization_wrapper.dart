import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Files
import '/config/_config.dart';
import 'theme_wrapper.dart';

class LocalizationWrapper extends StatelessWidget {
  const LocalizationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ], // add other languages here
      path: 'assets/translations',
      startLocale: const Locale('en'),
      fallbackLocale: const Locale('en'),
      child: BlocProvider(
        create: (_) => LanguageCubit(const Locale('en')),
        child: const ThemeWrapper(),
      ),
    );
  }
}
