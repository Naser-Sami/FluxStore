import '/core/_core.dart';
import '/features/_features.dart';

Future<void> initUseCases() async {
  _authentication();
  _profile();
  _categories();
  _products();
}

Future<void> _authentication() async {
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(repository: sl<ILoginRepository>()),
  );
  sl.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(repository: sl<ISignUpRepository>()),
  );
  sl.registerLazySingleton<ForgotPasswordUseCase>(
    () => ForgotPasswordUseCase(repository: sl<IForgotPasswordRepository>()),
  );
  sl.registerLazySingleton<ResetPasswordUseCase>(
    () => ResetPasswordUseCase(repository: sl<IResetPasswordRepository>()),
  );
}

Future<void> _profile() async {
  sl.registerLazySingleton<GetProfileUseCase>(
    () => GetProfileUseCase(repository: sl<IProfileRepository>()),
  );
  sl.registerLazySingleton<UpdateProfileUseCase>(
    () => UpdateProfileUseCase(repository: sl<IProfileRepository>()),
  );
  sl.registerLazySingleton<UpdateProfileImageUseCase>(
    () => UpdateProfileImageUseCase(repository: sl<IProfileRepository>()),
  );
}

Future<void> _categories() async {
  sl.registerLazySingleton<GetAllCategoriesUseCase>(
    () => GetAllCategoriesUseCase(repository: sl<ICategoriesRepository>()),
  );
  sl.registerLazySingleton<GetCategoryUseCase>(
    () => GetCategoryUseCase(repository: sl<ICategoriesRepository>()),
  );
  sl.registerLazySingleton<CreateCategoryUseCase>(
    () => CreateCategoryUseCase(repository: sl<ICategoriesRepository>()),
  );
  sl.registerLazySingleton<UpdateCategoryUseCase>(
    () => UpdateCategoryUseCase(repository: sl<ICategoriesRepository>()),
  );
  sl.registerLazySingleton<DeleteCategoryUseCase>(
    () => DeleteCategoryUseCase(repository: sl<ICategoriesRepository>()),
  );
}

Future<void> _products() async {
  sl.registerLazySingleton<GetProductsUseCase>(
    () => GetProductsUseCase(repository: sl<IProductRepository>()),
  );
  sl.registerLazySingleton<GetProductByIdUseCase>(
    () => GetProductByIdUseCase(productRepository: sl<IProductRepository>()),
  );
  sl.registerLazySingleton<AddProductUseCase>(
    () => AddProductUseCase(repository: sl<IProductRepository>()),
  );
  sl.registerLazySingleton<UpdateProductUseCase>(
    () => UpdateProductUseCase(repository: sl<IProductRepository>()),
  );
  sl.registerLazySingleton<DeleteProductUseCase>(
    () => DeleteProductUseCase(repository: sl<IProductRepository>()),
  );
  sl.registerLazySingleton<GetProductDetailsUseCase>(
    () => GetProductDetailsUseCase(repository: sl<IProductRepository>()),
  );
  sl.registerLazySingleton<AddReviewUseCase>(
    () => AddReviewUseCase(repository: sl<IProductRepository>()),
  );
}
