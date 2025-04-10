import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/_config.dart' show ThemeCubit, BottomNavigationBarCubit;
import '/core/_core.dart' show sl;
import '/features/_features.dart';

final providers = [
  BlocProvider<ThemeCubit>(create: (context) => sl<ThemeCubit>()),
  BlocProvider<BottomNavigationBarCubit>(
    create: (context) => sl<BottomNavigationBarCubit>(),
  ),
  BlocProvider<UserSessionCubit>(create: (context) => sl<UserSessionCubit>()),
  BlocProvider<DrawerCubit>(
    create: (context) => sl<DrawerCubit>()..loadDrawerItems(),
  ),
  BlocProvider<OnDrawerTapCubit>(create: (context) => sl<OnDrawerTapCubit>()),
];
