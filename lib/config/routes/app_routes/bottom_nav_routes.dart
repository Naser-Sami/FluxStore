import 'package:flutter/cupertino.dart' show CupertinoPage;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/_core.dart'
    show
        aboutUsSectionNavigator,
        cartSectionNavigator,
        homeSectionNavigator,
        profileSectionNavigator,
        searchSectionNavigator,
        settingsSectionNavigator,
        supportSectionNavigator;
import '/features/_features.dart';

final bottomNavRoutes = [
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
                (context, state) => const CupertinoPage(child: SearchScreen()),
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
                (context, state) => const CupertinoPage(child: ProfileScreen()),
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
];
