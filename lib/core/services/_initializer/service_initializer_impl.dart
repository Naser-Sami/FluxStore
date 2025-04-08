import 'package:easy_localization/easy_localization.dart' show EasyLocalization;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;
import 'package:flutter_native_splash/flutter_native_splash.dart'
    show FlutterNativeSplash;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;
import 'package:url_strategy/url_strategy.dart' show setPathUrlStrategy;

import '/core/_core.dart' show DI, ISendEmailOtpService, sl;
import '/firebase_options.dart';
import 'service_initializer.dart';

class ServiceInitializer extends IServiceInitializer {
  @override
  Future<void> init() async {
    initSplashScreen();
    await initLocalization();
    await initScreenUtils();
    initPathUrlStrategy();
    initGoRouter();
    await initHydratedBloc();
    await initDotEnv();
    await initStripe();
    await initFirebase();
    await initFirebaseMessaging();
    await initServiceLocator();
    await initEmailOtpService();
    removeSplashScreen();
  }

  @override
  void initSplashScreen() {
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  }

  @override
  void initPathUrlStrategy() {
    setPathUrlStrategy();
  }

  @override
  void initGoRouter() {
    GoRouter.optionURLReflectsImperativeAPIs = true;
  }

  @override
  Future<void> initLocalization() async {
    await EasyLocalization.ensureInitialized();
  }

  @override
  Future<void> initScreenUtils() async {
    await ScreenUtil.ensureScreenSize();
  }

  @override
  Future<void> initHydratedBloc() async {
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory:
          kIsWeb
              ? HydratedStorageDirectory.web
              : HydratedStorageDirectory((await getTemporaryDirectory()).path),
    );
  }

  @override
  Future<void> initDotEnv() async {
    await dotenv.load(fileName: "assets/.env");
  }

  @override
  Future<void> initStripe() async {
    // StripeService.init();
    // Stripe.instance.applySettings();
  }

  @override
  Future<void> initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Future<void> initFirebaseMessaging() async {
    // MessagingConfig.initFirebaseMessaging();
    // FirebaseMessaging.onBackgroundMessage(MessagingConfig.messageHandler);
  }

  @override
  Future<void> initServiceLocator() async {
    await DI().init();
  }

  @override
  void removeSplashScreen() {
    FlutterNativeSplash.remove();
  }

  @override
  Future<void> initEmailOtpService() async {
    await sl<ISendEmailOtpService>().config();
  }
}
