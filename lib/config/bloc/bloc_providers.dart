import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/_features.dart';
import '/config/_config.dart' show ThemeCubit;
import '/core/_core.dart' show sl;

final providers = [
  BlocProvider<ThemeCubit>(create: (context) => sl<ThemeCubit>()),
  BlocProvider<LoginBloc>(create: (context) => sl<LoginBloc>()),
];
