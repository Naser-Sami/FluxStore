import 'package:flutter/cupertino.dart' show CupertinoPage;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart' show scaleDownTransitionPage;
import '/core/_core.dart'
    show adminCategorySectionNavigator, adminProductSectionNavigator, sl;
import '/features/_features.dart';

final adminRoutes = [
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
                        BlocProvider(create: (context) => ProductColorsCubit()),
                        BlocProvider(
                          create: (context) => ProductCategoryDropdownCubit(),
                        ),
                        BlocProvider(create: (context) => ProductSizesCubit()),
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
                        BlocProvider(create: (context) => ProductColorsCubit()),
                        BlocProvider(
                          create: (context) => ProductCategoryDropdownCubit(),
                        ),
                        BlocProvider(create: (context) => ProductSizesCubit()),
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
];
