import '/config/_config.dart';
import '/core/_core.dart';
import '/features/_features.dart';

Future<void> initControllers() async {
  _theme();
  _bottomNavigationBar();
  _drawer();
  _authentication();
  _userSession();
  _profile();
  _categories();
  _products();
  _filter();
}

Future<void> _theme() async {
  sl.registerFactory<ThemeCubit>(ThemeCubit.new);
}

Future<void> _bottomNavigationBar() async {
  sl.registerFactory<BottomNavigationBarCubit>(BottomNavigationBarCubit.new);
}

Future<void> _drawer() async {
  sl.registerFactory<DrawerCubit>(DrawerCubit.new);
  sl.registerFactory<OnDrawerTapCubit>(OnDrawerTapCubit.new);
  sl.registerFactory<DrawerGestureCubit>(DrawerGestureCubit.new);
}

Future<void> _authentication() async {
  sl.registerFactory<LoginBloc>(
    () => LoginBloc(loginUseCase: sl<LoginUseCase>()),
  );
  sl.registerFactory<SignUpBloc>(
    () => SignUpBloc(signUpUseCase: sl<SignUpUseCase>()),
  );
  sl.registerFactory<ForgotPasswordCubit>(
    () =>
        ForgotPasswordCubit(forgotPasswordUseCase: sl<ForgotPasswordUseCase>()),
  );
  sl.registerFactory<ResetPasswordCubit>(
    () => ResetPasswordCubit(resetPasswordUseCase: sl<ResetPasswordUseCase>()),
  );
}

Future<void> _userSession() async {
  sl.registerFactory<UserSessionCubit>(UserSessionCubit.new);
}

Future<void> _profile() async {
  sl.registerFactory<ProfileBloc>(
    () => ProfileBloc(
      getProfileUseCase: sl<GetProfileUseCase>(),
      updateProfileUseCase: sl<UpdateProfileUseCase>(),
      updateProfileImageUseCase: sl<UpdateProfileImageUseCase>(),
    ),
  );
}

Future<void> _categories() async {
  sl.registerFactory<CategoryBloc>(
    () => CategoryBloc(
      getAllCategoriesUseCase: sl<GetAllCategoriesUseCase>(),
      getCategoryUseCase: sl<GetCategoryUseCase>(),
      createCategoryUseCase: sl<CreateCategoryUseCase>(),
      updateCategoryUseCase: sl<UpdateCategoryUseCase>(),
      deleteCategoryUseCase: sl<DeleteCategoryUseCase>(),
    ),
  );
  sl.registerFactory<SelectedCategoryCubit>(SelectedCategoryCubit.new);
}

Future<void> _products() async {
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

Future<void> _filter() async {
  sl.registerFactory<FilterPriceCubit>(FilterPriceCubit.new);
  sl.registerFactory<FilterColorsController>(FilterColorsController.new);
}
