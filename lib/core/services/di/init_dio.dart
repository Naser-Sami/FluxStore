import '/core/_core.dart';

Future<void> initDio() async {
  sl.registerLazySingleton<DioService>(DioService.new);
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(dio: sl<DioService>().dio),
  );
}
