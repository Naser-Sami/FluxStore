import '/core/_core.dart';
import '/features/_features.dart';

Future<void> initRepositories() async {
  _authentication();
  _profile();
  _categories();
  _products();
  _cart();
}

Future<void> _authentication() async {
  sl.registerLazySingleton<ILoginRepository>(
    () => LoginRepository(dataSource: sl<IAuthenticationRemoteDataSource>()),
  );
  sl.registerLazySingleton<ISignUpRepository>(
    () => SignUpRepository(dataSource: sl<IAuthenticationRemoteDataSource>()),
  );
  sl.registerLazySingleton<IForgotPasswordRepository>(
    () => ForgotPasswordRepository(
      dataSource: sl<IAuthenticationRemoteDataSource>(),
    ),
  );
  sl.registerLazySingleton<IResetPasswordRepository>(
    () => ResetPasswordRepository(
      dataSource: sl<IAuthenticationRemoteDataSource>(),
    ),
  );
}

Future<void> _profile() async {
  sl.registerLazySingleton<IProfileRepository>(
    () => ProfileRepository(dataSource: sl<IProfileRemoteDataSource>()),
  );
}

Future<void> _categories() async {
  sl.registerLazySingleton<ICategoriesRepository>(
    () => CategoriesRepository(dataSource: sl<ICategoriesRemoteDataSource>()),
  );
}

Future<void> _products() async {
  sl.registerLazySingleton<IProductRepository>(
    () => ProductRepository(dataSource: sl<IProductRemoteDataSource>()),
  );
}

Future<void> _cart() async {
  sl.registerLazySingleton<ICartRepository>(
    () => CartRepository(dataSource: sl<ICartRemoteDataSource>()),
  );
}
