import 'package:flutter/material.dart'
    show WidgetsBinding, WidgetsFlutterBinding;

abstract class IServiceInitializer {
  Future<void> init();
  WidgetsBinding get widgetsBinding =>
      WidgetsFlutterBinding.ensureInitialized();
  void initSplashScreen();
  Future<void> initLocalization();
  Future<void> initScreenUtils();
  void initPathUrlStrategy();
  void initGoRouter();
  Future<void> initHydratedBloc();
  Future<void> initDotEnv();
  Future<void> initStripe();
  Future<void> initFirebase();
  Future<void> initFirebaseMessaging();
  Future<void> initServiceLocator();
  Future<void> initEmailOtpService();
  void removeSplashScreen();
}
