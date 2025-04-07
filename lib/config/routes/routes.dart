import 'package:go_router/go_router.dart';

import '/config/_config.dart';
import '/core/_core.dart';
import '/features/_features.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: WelcomeScreen.routeName,
  observers: [AppNavigatorObserver()],
  navigatorKey: navigatorKey,
  errorBuilder: (context, state) {
    if (state.uri.path.contains('/link')) {}

    return ErrorPage(state.error.toString());
  },
  redirect: (context, state) {
    if (state.uri.path.contains('/link')) {
      // return BottomNavigationBarWidget.routeName;
    }
    return null;
  },
  routes: [
    GoRoute(
      path: WelcomeScreen.routeName,
      name: WelcomeScreen.name,
      pageBuilder:
          (context, state) =>
              scaleDownTransitionPage(context, state, const WelcomeScreen()),
    ),
    GoRoute(
      path: OnboardingScreen.routeName,
      name: OnboardingScreen.name,
      pageBuilder:
          (context, state) =>
              scaleDownTransitionPage(context, state, const OnboardingScreen()),
    ),

    ///
    /// Authentication
    ///
    /// - Create Account
    GoRoute(
      path: CreateAccountScreen.routeName,
      name: CreateAccountScreen.name,
      pageBuilder:
          (context, state) => scaleDownTransitionPage(
            context,
            state,
            const CreateAccountScreen(),
          ),
    ),

    /// - Login
    GoRoute(
      path: LoginScreen.routeName,
      name: LoginScreen.name,
      pageBuilder:
          (context, state) =>
              scaleDownTransitionPage(context, state, const LoginScreen()),
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
          VerificationCodeScreen(email: email),
        );
      },
    ),

    /// - Create New Password
    GoRoute(
      path: CreateNewPasswordScreen.routeName,
      name: CreateNewPasswordScreen.name,
      pageBuilder:
          (context, state) => scaleDownTransitionPage(
            context,
            state,
            const CreateNewPasswordScreen(),
          ),
    ),

    ///
    /// End Authentication
    ///
  ],
);
