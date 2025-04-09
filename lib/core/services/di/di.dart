import 'package:get_it/get_it.dart';

import '/config/_config.dart';
import '/core/_core.dart';
import '/features/_features.dart';

// Global Variable
// Initialize GetIt
final sl = GetIt.I;

class DI {
  Future<void> initDio() async {
    sl.registerLazySingleton<DioService>(DioService.new);
  }

  Future<void> initSecureStorageService() async {
    sl.registerLazySingleton<SecureStorageService>(SecureStorageService.new);
  }

  Future<void> initFirebase() async {}

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
  }

  Future<void> initDataSources() async {
    // Authentication
    sl.registerLazySingleton<IAuthenticationRemoteDataSource>(
      AuthenticationRemoteDataSource.new,
    );

    // Categories
    sl.registerLazySingleton<ICategoriesRemoteDataSource>(
      CategoriesRemoteDataSourceImpl.new,
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

    // Categories
    sl.registerLazySingleton<ICategoriesRepository>(
      () => CategoriesRepositoryImplementation(
        categoriesRemoteDataSource: sl<ICategoriesRemoteDataSource>(),
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
  }

  Future<void> initControllers() async {
    sl.registerLazySingleton<ThemeCubit>(ThemeCubit.new);
    sl.registerLazySingleton<BottomNavigationBarCubit>(
      BottomNavigationBarCubit.new,
    );
    sl.registerLazySingleton<DrawerCubit>(DrawerCubit.new);
    sl.registerLazySingleton<OnDrawerTapCubit>(OnDrawerTapCubit.new);
    sl.registerLazySingleton<UserSessionCubit>(UserSessionCubit.new);
    sl.registerLazySingleton<LoginBloc>(
      () => LoginBloc(loginUseCase: sl<LoginUseCase>()),
    );
    sl.registerLazySingleton<SignUpBloc>(
      () => SignUpBloc(signUpUseCase: sl<SignUpUseCase>()),
    );
    sl.registerLazySingleton<ForgotPasswordCubit>(
      () => ForgotPasswordCubit(
        forgotPasswordUseCase: sl<ForgotPasswordUseCase>(),
      ),
    );
    sl.registerLazySingleton<ResetPasswordCubit>(
      () =>
          ResetPasswordCubit(resetPasswordUseCase: sl<ResetPasswordUseCase>()),
    );
    sl.registerLazySingleton<CategoryBloc>(
      () => CategoryBloc(
        getAllCategoriesUseCase: sl<GetAllCategoriesUseCase>(),
        getCategoryUseCase: sl<GetCategoryUseCase>(),
      ),
    );
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
