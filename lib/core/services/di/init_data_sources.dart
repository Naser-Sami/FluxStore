import '/core/_core.dart';
import '/features/_features.dart';

Future<void> initDataSources() async {
  _authentication();
  _profile();
  _categories();
  _products();
  _cart();
}

Future<void> _authentication() async {
  sl.registerLazySingleton<IAuthenticationRemoteDataSource>(
    AuthenticationRemoteDataSource.new,
  );
}

Future<void> _profile() async {
  sl.registerLazySingleton<IProfileRemoteDataSource>(
    ProfileRemoteDataSource.new,
  );
}

Future<void> _categories() async {
  sl.registerLazySingleton<ICategoriesRemoteDataSource>(
    CategoriesRemoteDataSource.new,
  );
}

Future<void> _products() async {
  sl.registerLazySingleton<IProductRemoteDataSource>(
    ProductRemoteDataSource.new,
  );
}

Future<void> _cart() async {
  sl.registerLazySingleton<ICartRemoteDataSource>(CartRemoteDataSource.new);
}
