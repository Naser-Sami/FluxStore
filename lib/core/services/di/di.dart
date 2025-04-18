import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '/config/_config.dart';
import '/core/_core.dart';
import '/features/_features.dart';

// Global Variable
// Initialize GetIt
final sl = GetIt.I;

class DI {
  Future<void> internetConnectionChecker() async {
    sl.registerLazySingleton<InternetConnectionCubit>(
      InternetConnectionCubit.new,
    );
  }

  Future<void> initDio() async {
    sl.registerLazySingleton<DioService>(DioService.new);
    sl.registerLazySingleton<ApiClient>(
      () => ApiClient(dio: sl<DioService>().dio),
    );
  }

  Future<void> initSecureStorageService() async {
    sl.registerLazySingleton<SecureStorageService>(SecureStorageService.new);
  }

  Future<void> initFirebase() async {
    final firebaseAuth = FirebaseAuth.instance;
    sl.registerLazySingleton<FirebaseAuth>(() => firebaseAuth);

    sl.registerLazySingleton<IFirebaseAuthService>(FirebaseAuthServiceImpl.new);

    sl.registerLazySingleton<ISocialSignInService>(SocialSignInServiceImpl.new);
  }

  Future<void> initFirebaseFirestore() async {}

  Future<void> initFirebaseMessaging() async {}

  Future<void> initServices() async {
    sl.registerLazySingleton<INotificationsService>(
      NotificationsServiceImpl.new,
    );

    sl.registerLazySingleton<IGeolocatorService>(GeolocatorServiceImpl.new);

    sl.registerLazySingleton<IGeocodingService>(GeocodingServiceImpl.new);

    sl.registerLazySingleton<IGeoCodeService>(GeoCodeServiceImpl.new);

    sl.registerLazySingleton<ISendEmailOtpService>(SendEmailOtpServiceImpl.new);

    sl.registerLazySingleton(RefreshTokenHandler.new);
    sl.registerLazySingleton(() => AuthService(sl<RefreshTokenHandler>()));
  }

  Future<void> initDataSources() async {
    // Authentication
    sl.registerLazySingleton<IAuthenticationRemoteDataSource>(
      AuthenticationRemoteDataSource.new,
    );

    // Profile
    sl.registerLazySingleton<IProfileRemoteDataSource>(
      ProfileRemoteDataSourceImpl.new,
    );

    // Categories
    sl.registerLazySingleton<ICategoriesRemoteDataSource>(
      CategoriesRemoteDataSourceImpl.new,
    );

    // Products
    sl.registerLazySingleton<IProductRemoteDataSource>(
      ProductRemoteDataSourceImpl.new,
    );
  }

  Future<void> initRepositories() async {
    // Authentication
    sl.registerLazySingleton<ILoginRepository>(
      () => LoginRepositoryImplementation(
        authenticationRemoteDataSource: sl<IAuthenticationRemoteDataSource>(),
      ),
    );
    sl.registerLazySingleton<ISignUpRepository>(
      () => SignUpRepositoryImplementation(
        authenticationRemoteDataSource: sl<IAuthenticationRemoteDataSource>(),
      ),
    );
    sl.registerLazySingleton<IForgotPasswordRepository>(
      () => ForgotPasswordRepositoryImplementation(
        authenticationRemoteDataSource: sl<IAuthenticationRemoteDataSource>(),
      ),
    );
    sl.registerLazySingleton<IResetPasswordRepository>(
      () => ResetPasswordRepositoryImplementation(
        authenticationRemoteDataSource: sl<IAuthenticationRemoteDataSource>(),
      ),
    );

    // Profile
    sl.registerLazySingleton<IProfileRepository>(
      () => ProfileRepositoryImplementation(
        remoteDataSource: sl<IProfileRemoteDataSource>(),
      ),
    );

    // Categories
    sl.registerLazySingleton<ICategoriesRepository>(
      () => CategoriesRepositoryImplementation(
        remoteDataSource: sl<ICategoriesRemoteDataSource>(),
      ),
    );

    // Products
    sl.registerLazySingleton<IProductRepository>(
      () => ProductRepositoryImplementation(
        remoteDataSource: sl<IProductRemoteDataSource>(),
      ),
    );
  }

  Future<void> initUseCases() async {
    //  Authentication
    sl.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(loginRepository: sl<ILoginRepository>()),
    );
    sl.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(signUpRepository: sl<ISignUpRepository>()),
    );
    sl.registerLazySingleton<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(
        forgotPasswordRepository: sl<IForgotPasswordRepository>(),
      ),
    );
    sl.registerLazySingleton<ResetPasswordUseCase>(
      () => ResetPasswordUseCase(
        resetPasswordRepository: sl<IResetPasswordRepository>(),
      ),
    );

    // Profile
    sl.registerLazySingleton<GetProfileUseCase>(
      () => GetProfileUseCase(repository: sl<IProfileRepository>()),
    );
    sl.registerLazySingleton<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(repository: sl<IProfileRepository>()),
    );
    sl.registerLazySingleton<UpdateProfileImageUseCase>(
      () => UpdateProfileImageUseCase(repository: sl<IProfileRepository>()),
    );

    // Categories
    sl.registerLazySingleton<GetAllCategoriesUseCase>(
      () => GetAllCategoriesUseCase(
        categoriesRepository: sl<ICategoriesRepository>(),
      ),
    );
    sl.registerLazySingleton<GetCategoryUseCase>(
      () =>
          GetCategoryUseCase(categoriesRepository: sl<ICategoriesRepository>()),
    );
    sl.registerLazySingleton<CreateCategoryUseCase>(
      () => CreateCategoryUseCase(
        categoriesRepository: sl<ICategoriesRepository>(),
      ),
    );
    sl.registerLazySingleton<UpdateCategoryUseCase>(
      () => UpdateCategoryUseCase(
        categoriesRepository: sl<ICategoriesRepository>(),
      ),
    );
    sl.registerLazySingleton<DeleteCategoryUseCase>(
      () => DeleteCategoryUseCase(
        categoriesRepository: sl<ICategoriesRepository>(),
      ),
    );

    // Products
    sl.registerLazySingleton<GetProductsUseCase>(
      () => GetProductsUseCase(productRepository: sl<IProductRepository>()),
    );
    sl.registerLazySingleton<GetProductByIdUseCase>(
      () => GetProductByIdUseCase(productRepository: sl<IProductRepository>()),
    );
    sl.registerLazySingleton<AddProductUseCase>(
      () => AddProductUseCase(productRepository: sl<IProductRepository>()),
    );
    sl.registerLazySingleton<UpdateProductUseCase>(
      () => UpdateProductUseCase(productRepository: sl<IProductRepository>()),
    );
    sl.registerLazySingleton<DeleteProductUseCase>(
      () => DeleteProductUseCase(productRepository: sl<IProductRepository>()),
    );
    sl.registerLazySingleton<GetProductDetailsUseCase>(
      () =>
          GetProductDetailsUseCase(productRepository: sl<IProductRepository>()),
    );
    sl.registerLazySingleton<AddReviewUseCase>(
      () => AddReviewUseCase(productRepository: sl<IProductRepository>()),
    );
  }

  Future<void> initControllers() async {
    sl.registerFactory<ThemeCubit>(ThemeCubit.new);
    sl.registerFactory<BottomNavigationBarCubit>(BottomNavigationBarCubit.new);
    sl.registerFactory<DrawerCubit>(DrawerCubit.new);
    sl.registerFactory<OnDrawerTapCubit>(OnDrawerTapCubit.new);
    sl.registerFactory<UserSessionCubit>(UserSessionCubit.new);
    sl.registerFactory<LoginBloc>(
      () => LoginBloc(loginUseCase: sl<LoginUseCase>()),
    );
    sl.registerFactory<SignUpBloc>(
      () => SignUpBloc(signUpUseCase: sl<SignUpUseCase>()),
    );
    sl.registerFactory<ForgotPasswordCubit>(
      () => ForgotPasswordCubit(
        forgotPasswordUseCase: sl<ForgotPasswordUseCase>(),
      ),
    );
    sl.registerFactory<ResetPasswordCubit>(
      () =>
          ResetPasswordCubit(resetPasswordUseCase: sl<ResetPasswordUseCase>()),
    );
    sl.registerFactory<ProfileBloc>(
      () => ProfileBloc(
        getProfileUseCase: sl<GetProfileUseCase>(),
        updateProfileUseCase: sl<UpdateProfileUseCase>(),
        updateProfileImageUseCase: sl<UpdateProfileImageUseCase>(),
      ),
    );
    sl.registerFactory<CategoryBloc>(
      () => CategoryBloc(
        getAllCategoriesUseCase: sl<GetAllCategoriesUseCase>(),
        getCategoryUseCase: sl<GetCategoryUseCase>(),
        createCategoryUseCase: sl<CreateCategoryUseCase>(),
        updateCategoryUseCase: sl<UpdateCategoryUseCase>(),
        deleteCategoryUseCase: sl<DeleteCategoryUseCase>(),
      ),
    );

    sl.registerFactory<ProductsBloc>(
      () => ProductsBloc(
        addProductUseCase: sl<AddProductUseCase>(),
        getProductsUseCase: sl<GetProductsUseCase>(),
        updateProductUseCase: sl<UpdateProductUseCase>(),
        deleteProductUseCase: sl<DeleteProductUseCase>(),
        getProductByIdUseCase: sl<GetProductByIdUseCase>(),
      ),
    );
    sl.registerFactory<ProductDetailsBloc>(
      () => ProductDetailsBloc(
        getProductDetailsUseCase: sl<GetProductDetailsUseCase>(),
        addReviewUseCase: sl<AddReviewUseCase>(),
      ),
    );
  }

  Future<void> init() async {
    await internetConnectionChecker();
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
