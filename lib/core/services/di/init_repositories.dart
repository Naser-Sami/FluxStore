import '/core/_core.dart';
import '/features/_features.dart';

Future<void> initRepositories() async {
  _authentication();
  _profile();
  _categories();
  _products();
}

Future<void> _authentication() async {
  sl.registerLazySingleton<ILoginRepository>(
    () => LoginRepository(
      remoteDataSource: sl<IAuthenticationRemoteDataSource>(),
    ),
  );
  sl.registerLazySingleton<ISignUpRepository>(
    () => SignUpRepository(
      remoteDataSource: sl<IAuthenticationRemoteDataSource>(),
    ),
  );
  sl.registerLazySingleton<IForgotPasswordRepository>(
    () => ForgotPasswordRepository(
      remoteDataSource: sl<IAuthenticationRemoteDataSource>(),
    ),
  );
  sl.registerLazySingleton<IResetPasswordRepository>(
    () => ResetPasswordRepository(
      remoteDataSource: sl<IAuthenticationRemoteDataSource>(),
    ),
  );
}

Future<void> _profile() async {
  sl.registerLazySingleton<IProfileRepository>(
    () => ProfileRepository(remoteDataSource: sl<IProfileRemoteDataSource>()),
  );
}

Future<void> _categories() async {
  sl.registerLazySingleton<ICategoriesRepository>(
    () => CategoriesRepository(
      remoteDataSource: sl<ICategoriesRemoteDataSource>(),
    ),
  );
}

Future<void> _products() async {
  sl.registerLazySingleton<IProductRepository>(
    () => ProductRepository(remoteDataSource: sl<IProductRemoteDataSource>()),
  );
}
