import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    // final user = await sl<UserSessionCubit>().getSavedUser();

    // if (user?.role.toLowerCase() == 'admin' &&
    //     !state.matchedLocation.startsWith('/admin')) {
    //   return AdminScreen.routeName;
    // }
    // if (user?.role.toLowerCase() == 'customer' &&
    //     state.matchedLocation.startsWith('/admin')) {
    //   return HomeScreen.routeName;
    // }

    return null;
  },
  routes: [
    GoRoute(
      path: NoInternetConnectionScreen.routeName,
      name: NoInternetConnectionScreen.name,
      builder: (context, state) {
        return const NoInternetConnectionScreen();
      },
    ),
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

    // ADMIN
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return BlocProvider<ProfileBloc>(
          create: (context) => sl<ProfileBloc>()..add(const GetProfileEvent()),
          child: AdminScreen(navigationShell: navigationShell),
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: adminCategorySectionNavigator,
          routes: [
            GoRoute(
              path: AdminCategoryScreen.routeName,
              name: AdminCategoryScreen.name,
              pageBuilder:
                  (context, state) =>
                      const CupertinoPage(child: AdminCategoryScreen()),
              routes: [
                GoRoute(
                  path: AddCategoryScreen.routeName,
                  name: AddCategoryScreen.name,
                  pageBuilder: (context, state) {
                    return scaleDownTransitionPage(
                      context,
                      state,
                      const AddCategoryScreen(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: adminProductSectionNavigator,
          routes: [
            GoRoute(
              path: AdminProductsScreen.routeName,
              name: AdminProductsScreen.name,
              pageBuilder:
                  (context, state) =>
                      const CupertinoPage(child: AdminProductsScreen()),
              routes: [
                GoRoute(
                  path: AdminAddProductScreen.routeName,
                  name: AdminAddProductScreen.name,
                  pageBuilder: (context, state) {
                    return CupertinoPage(
                      child: MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => ProductColorsCubit(),
                          ),
                          BlocProvider(
                            create: (context) => ProductCategoryDropdownCubit(),
                          ),
                          BlocProvider(
                            create: (context) => ProductSizesCubit(),
                          ),
                          BlocProvider(
                            create: (context) => ProductMainImageCubit(),
                          ),
                          BlocProvider(
                            create: (context) => ProductSubImagesCubit(),
                          ),
                        ],
                        child: const AdminAddProductScreen(),
                      ),
                    );
                  },
                ),
                GoRoute(
                  path: UpdateProductScreen.routeName,
                  name: UpdateProductScreen.name,
                  pageBuilder: (context, state) {
                    final extra = state.extra as Map<String, dynamic>;
                    final productId = extra['productId'] as String;

                    return CupertinoPage(
                      child: MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => ProductColorsCubit(),
                          ),
                          BlocProvider(
                            create: (context) => ProductCategoryDropdownCubit(),
                          ),
                          BlocProvider(
                            create: (context) => ProductSizesCubit(),
                          ),
                          BlocProvider(
                            create: (context) => ProductMainImageCubit(),
                          ),
                          BlocProvider(
                            create: (context) => ProductSubImagesCubit(),
                          ),
                        ],
                        child: UpdateProductScreen(productId: productId),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),

    /// ---------------------------------------------------------
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

    /// ---------------------------------------------------------
    /// End Authentication

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
              path: HomeScreen.routeName,
              name: HomeScreen.name,
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
              path: SearchScreen.routeName,
              name: SearchScreen.name,
              pageBuilder:
                  (context, state) =>
                      const CupertinoPage(child: SearchScreen()),
            ),
            GoRoute(
              path: SearchResultScreen.routeName,
              name: SearchResultScreen.name,
              pageBuilder: (context, state) {
                final query = state.extra as ProductQueryParameters?;

                return CupertinoPage(child: SearchResultScreen(query: query));
              },
            ),
          ],
        ),

        //  Cart Shell Branch
        StatefulShellBranch(
          navigatorKey: cartSectionNavigator,
          routes: [
            GoRoute(
              path: CartScreen.routeName,
              name: CartScreen.name,
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
              path: ProfileScreen.routeName,
              name: ProfileScreen.name,
              pageBuilder:
                  (context, state) =>
                      const CupertinoPage(child: ProfileScreen()),
            ),
          ],
        ),

        //  Settings Shell Branch
        StatefulShellBranch(
          navigatorKey: settingsSectionNavigator,
          routes: [
            GoRoute(
              path: '/settings',
              name: 'Settings',
              pageBuilder:
                  (context, state) => const CupertinoPage(
                    child: Scaffold(body: Center(child: Text("Settings"))),
                  ),
            ),
          ],
        ),

        //  Settings Shell Branch
        StatefulShellBranch(
          navigatorKey: supportSectionNavigator,
          routes: [
            GoRoute(
              path: '/support',
              name: 'Support',
              pageBuilder:
                  (context, state) => const CupertinoPage(
                    child: Scaffold(body: Center(child: Text("Support"))),
                  ),
            ),
          ],
        ),

        //  About Us Shell Branch
        StatefulShellBranch(
          navigatorKey: aboutUsSectionNavigator,
          routes: [
            GoRoute(
              path: '/about-us',
              name: 'About Us',
              pageBuilder:
                  (context, state) => const CupertinoPage(
                    child: Scaffold(body: Center(child: Text("About Us"))),
                  ),
            ),
          ],
        ),
      ],
    ),

    /// ..
    /// End Bottom Navigation Bar
    GoRoute(
      path: ProfileSettingsScreen.routeName,
      name: ProfileSettingsScreen.name,
      pageBuilder:
          (context, state) =>
              const CupertinoPage(child: ProfileSettingsScreen()),
    ),

    /// ..
    /// Products
    GoRoute(
      path: ProductDetailsScreen.routeName,
      name: ProductDetailsScreen.name,
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final productId = extra['productId'];
        return CupertinoPage(child: ProductDetailsScreen(productId: productId));
      },
    ),

    // Stocks
    GoRoute(
      path: RealTimeStockWidget.routeName,
      name: RealTimeStockWidget.name,
      pageBuilder: (context, state) {
        return CupertinoPage(child: RealTimeStockWidget());
      },
    ),
  ],
);
