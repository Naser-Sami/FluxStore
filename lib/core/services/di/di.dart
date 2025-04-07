import 'package:get_it/get_it.dart';

import '/core/_core.dart';
import '/config/_config.dart';

// Global Variable
// Initialize GetIt
final sl = GetIt.I;

class DI {
  Future<void> initDio() async {
    sl.registerLazySingleton<DioService>(() => DioService());
  }

  Future<void> initSecureStorageService() async {
    sl.registerLazySingleton<SecureStorageService>(
      () => SecureStorageService(),
    );
  }

  Future<void> initFirebase() async {}

  Future<void> initFirebaseFirestore() async {}

  Future<void> initFirebaseMessaging() async {}

  Future<void> initServices() async {
    sl.registerLazySingleton<INotificationsService>(
      () => NotificationsServiceImpl(),
    );

    sl.registerLazySingleton<IGeolocatorService>(() => GeolocatorServiceImpl());

    sl.registerLazySingleton<IGeocodingService>(() => GeocodingServiceImpl());

    sl.registerLazySingleton<IGeoCodeService>(() => GeoCodeServiceImpl());
  }

  Future<void> initDataSources() async {}

  Future<void> initRepositories() async {}

  Future<void> initUseCases() async {}

  Future<void> initControllers() async {
    sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
  }

  Future<void> init() async {
    await initServices();
    await initDataSources();
    await initRepositories();
    await initUseCases();
    await initControllers();
    await initDio();
    await initSecureStorageService();
    await initFirebase();
    await initFirebaseFirestore();
    await initFirebaseMessaging();
  }
}
