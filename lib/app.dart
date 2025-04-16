import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Files
import '/config/_config.dart';
import '/core/_core.dart'
    show AppConfig, InternetConnectionCubit, InternetStatus;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const LocalizationWrapper();
  }
}

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

class ThemeWrapper extends StatelessWidget {
  const ThemeWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => unfocusKeyboard(context),
          child: ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            child: BlocBuilder<InternetConnectionCubit, InternetStatus>(
              builder: (context, status) {
                if (status == InternetStatus.disconnected) {
                  return const MaterialApp(
                    title: AppConfig.appName,
                    debugShowCheckedModeBanner: false,
                    home: Scaffold(
                      body: SafeArea(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.wifi_off, size: 80, color: Colors.red),
                              SizedBox(height: 10),
                              Text('No Internet Connection'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return MaterialApp.router(
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
                );
              },
            ),
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
