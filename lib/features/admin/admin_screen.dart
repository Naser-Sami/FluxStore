import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart' show TextWidget, TSize, TPadding;
import '/core/_core.dart' show BuildContextExtensions, LocaleKeys, sl;
import '/features/_features.dart' show SplashScreen, UserSessionCubit;
import '_admin.dart';

class AdminScreen extends StatelessWidget {
  static const String routeName = '/admin/dashboard';
  static const String name = 'Admin Dashboard';
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
        actions: [
          IconButton(
            onPressed: () {
              sl<UserSessionCubit>().logout();
              context.go(SplashScreen.routeName);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(TPadding.p24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: TSize.s24),
              TextButton(
                onPressed: () {
                  context.push(
                    AdminScreen.routeName + AdminCategoryScreen.routeName,
                  );
                },
                child: TextWidget(
                  LocaleKeys.Product_category,
                  style: context.textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: TSize.s24),
            ],
          ),
        ),
      ),
    );
  }
}
