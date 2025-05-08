import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Files
import '/config/_config.dart';
import '/core/_core.dart' show AppConfig;

class ThemeWrapper extends StatelessWidget {
  const ThemeWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => unfocusKeyboard(context),
          child: MaterialApp.router(
            title: AppConfig.appName,
            debugShowCheckedModeBanner: false,
            themeMode: state,
            theme: lightTheme,
            darkTheme: darkTheme,
            scrollBehavior: scrollBehavior,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            routerConfig: router,
          ),
        );
      },
    );
  }

  void unfocusKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
