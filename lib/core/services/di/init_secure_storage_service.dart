import '/core/_core.dart';

Future<void> initSecureStorageService() async {
  sl.registerLazySingleton<SecureStorageService>(SecureStorageService.new);
}
