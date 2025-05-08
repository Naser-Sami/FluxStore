import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart' show scaleDownTransitionPage;
import '/core/_core.dart' show sl;
import '/features/_features.dart';

final authRoutes = [
  GoRoute(
    path: CreateAccountScreen.routeName,
    name: CreateAccountScreen.name,
    pageBuilder:
        (context, state) => scaleDownTransitionPage(
          context,
          state,
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<SignUpBloc>()),
              BlocProvider(create: (context) => sl<LoginBloc>()),
            ],
            child: const CreateAccountScreen(),
          ),
        ),
  ),

  /// - Login
  GoRoute(
    path: LoginScreen.routeName,
    name: LoginScreen.name,
    pageBuilder:
        (context, state) => scaleDownTransitionPage(
          context,
          state,
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<SignUpBloc>()),
              BlocProvider(create: (context) => sl<LoginBloc>()),
            ],
            child: const LoginScreen(),
          ),
        ),
  ),

  /// - Forgot Password
  GoRoute(
    path: ForgotPasswordScreen.routeName,
    name: ForgotPasswordScreen.name,
    pageBuilder:
        (context, state) => scaleDownTransitionPage(
          context,
          state,
          const ForgotPasswordScreen(),
        ),
  ),

  /// - Verification Code
  GoRoute(
    path: VerificationCodeScreen.routeName,
    name: VerificationCodeScreen.name,
    pageBuilder: (context, state) {
      final args = state.extra as Map<String, dynamic>;
      final email = args['email'];

      return scaleDownTransitionPage(
        context,
        state,
        BlocProvider(
          create: (context) => sl<ForgotPasswordCubit>(),
          child: VerificationCodeScreen(email: email),
        ),
      );
    },
  ),

  /// - Create New Password
  GoRoute(
    path: CreateNewPasswordScreen.routeName,
    name: CreateNewPasswordScreen.name,
    pageBuilder: (context, state) {
      final args = state.extra as Map<String, dynamic>;
      final email = args['email'];
      final token = args['token'];

      return scaleDownTransitionPage(
        context,
        state,
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => sl<LoginBloc>()),
            BlocProvider(create: (context) => sl<ResetPasswordCubit>()),
          ],

          child: CreateNewPasswordScreen(email: email, token: token),
        ),
      );
    },
  ),
];
