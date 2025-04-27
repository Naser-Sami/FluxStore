import '/core/_core.dart';

Future<void> initServices() async {
  sl.registerLazySingleton<INotificationsService>(NotificationsServiceImpl.new);

  sl.registerLazySingleton<IGeolocatorService>(GeolocatorServiceImpl.new);

  sl.registerLazySingleton<IGeocodingService>(GeocodingServiceImpl.new);

  sl.registerLazySingleton<IGeoCodeService>(GeoCodeServiceImpl.new);

  sl.registerLazySingleton<ISendEmailOtpService>(SendEmailOtpServiceImpl.new);

  sl.registerLazySingleton(RefreshTokenHandler.new);

  sl.registerLazySingleton(() => AuthService(sl<RefreshTokenHandler>()));
}
