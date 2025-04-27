import '/core/_core.dart';

Future<void> internetConnectionChecker() async {
  sl.registerLazySingleton<InternetConnectionCubit>(
    InternetConnectionCubit.new,
  );
}
