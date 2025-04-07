import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/_config.dart' show ThemeCubit;
import '/core/_core.dart' show sl;
import '/features/_features.dart';

final providers = [
  BlocProvider<ThemeCubit>(create: (context) => sl<ThemeCubit>()),
  BlocProvider<UserSessionCubit>(create: (context) => sl<UserSessionCubit>()),
];
