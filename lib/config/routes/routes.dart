import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart';
import '/core/_core.dart';
import '/features/_features.dart';

// GoRouter configuration
final router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: SplashScreen.routeName,
  debugLogDiagnostics: true,
  // refreshListenable: GoRouterRefreshStream(sl<UserSessionCubit>()),
  observers: [AppNavigatorObserver()],
  errorBuilder: (context, state) {
    if (state.uri.path.contains('/link')) {}

    return ErrorPage(state.error.toString());
  },
  redirect: (context, state) async {
    if (state.uri.path.contains('/link')) {
      // return BottomNavigationBarWidget.routeName;
    }
    return null;
  },
  routes: [
    GoRoute(
      path: SplashScreen.routeName,
      name: SplashScreen.name,
      pageBuilder:
          (context, state) => const CupertinoPage(child: SplashScreen()),
    ),
    GoRoute(
      path: WelcomeScreen.routeName,
      name: WelcomeScreen.name,
      pageBuilder: (context, state) {
        return scaleDownTransitionPage(context, state, const WelcomeScreen());
      },
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
            BlocProvider(
              create: (context) => sl<SignUpBloc>(),
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
            BlocProvider(
              create: (context) => sl<LoginBloc>(),
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

        return scaleDownTransitionPage(
          context,
          state,
          BlocProvider(
            create: (context) => sl<ResetPasswordCubit>(),
            child: CreateNewPasswordScreen(email: email),
          ),
        );
      },
    ),

    ///
    /// End Authentication
    ///
    /// - Bottom Navigation Bar
    /// - Flux Store
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppBottomNavigationBar(navigationShell: navigationShell);
      },
      branches: [
        // Home Shell Branch
        StatefulShellBranch(
          navigatorKey: homeSectionNavigator,
          routes: [
            GoRoute(
              path: '/home',
              name: 'Home',
              pageBuilder:
                  (context, state) => const CupertinoPage(child: HomeScreen()),
            ),
          ],
        ),

        //  Search Shell Branch
        StatefulShellBranch(
          navigatorKey: searchSectionNavigator,
          routes: [
            GoRoute(
              path: '/search',
              name: 'Search',
              pageBuilder:
                  (context, state) =>
                      const CupertinoPage(child: SearchScreen()),
            ),
          ],
        ),

        //  Cart Shell Branch
        StatefulShellBranch(
          navigatorKey: cartSectionNavigator,
          routes: [
            GoRoute(
              path: '/cart',
              name: 'Cart',
              pageBuilder:
                  (context, state) => const CupertinoPage(child: CartScreen()),
            ),
          ],
        ),
        //  Profile Shell Branch
        StatefulShellBranch(
          navigatorKey: profileSectionNavigator,
          routes: [
            GoRoute(
              path: '/profile',
              name: 'Profile',
              pageBuilder:
                  (context, state) =>
                      const CupertinoPage(child: ProfileScreen()),
            ),
          ],
        ),
      ],
    ),

    /// ..
    /// End Bottom Navigation Bar
  ],
);
