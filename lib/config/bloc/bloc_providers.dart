import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/_config.dart' show ThemeCubit, BottomNavigationBarCubit;
import '/core/_core.dart' show InternetConnectionCubit, sl;
import '/features/_features.dart';

final providers = [
  BlocProvider<InternetConnectionCubit>(
    create: (context) => sl<InternetConnectionCubit>(),
  ),
  BlocProvider<ThemeCubit>(create: (context) => sl<ThemeCubit>()),
  BlocProvider<BottomNavigationBarCubit>(
    create: (context) => sl<BottomNavigationBarCubit>(),
  ),
  BlocProvider<ProfileBloc>(
    create: (context) => sl<ProfileBloc>()..add(const GetProfileEvent()),
  ),
  BlocProvider<UserSessionCubit>(create: (context) => sl<UserSessionCubit>()),

  // Drawer
  BlocProvider<DrawerCubit>(
    create: (context) => sl<DrawerCubit>()..loadDrawerItems(),
  ),
  BlocProvider<OnDrawerTapCubit>(create: (context) => sl<OnDrawerTapCubit>()),
  BlocProvider<DrawerGestureCubit>(
    create: (context) => sl<DrawerGestureCubit>(),
  ),

  BlocProvider<CategoryBloc>(
    create: (context) => sl<CategoryBloc>()..add(GetAllCategoryEvent()),
  ),
  BlocProvider<SelectedCategoryCubit>(
    create: (context) => sl<SelectedCategoryCubit>(),
  ),
  BlocProvider<ProductsBloc>(
    create: (context) => sl<ProductsBloc>()..add(const GetProductsEvent()),
  ),
  BlocProvider<ProductDetailsBloc>(
    create: (context) => sl<ProductDetailsBloc>(),
  ),
  BlocProvider<CartCubit>(create: (context) => sl<CartCubit>()),
];
