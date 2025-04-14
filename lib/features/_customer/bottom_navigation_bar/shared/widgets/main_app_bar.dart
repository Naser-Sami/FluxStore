import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart';
import '/core/_core.dart';
import '/features/_features.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key, required this.onMenuPressed});
  final VoidCallback onMenuPressed;

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: const Duration(milliseconds: 200),
      duration: const Duration(milliseconds: 1200),
      child: CustomAppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 100,
        leading: Padding(
          padding: EdgeInsetsDirectional.only(start: TPadding.p16.r),
          child: IconButton(
            icon: IconWidget(
              name: 'menu',
              color: context.theme.colorScheme.onSurface,
            ),
            onPressed: onMenuPressed,
          ),
        ),
        title: const TextWidget('Flux Store'),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              // show menu to change language
              sl<UserSessionCubit>().logout();
              context.go(SplashScreen.routeName);
            },
          ),
          IconButton(
            icon: IconWidget(
              name: 'notifications',
              color: context.theme.colorScheme.onSurface,
            ),
            onPressed: () {},
          ),
          SizedBox(width: TPadding.p16.r),
        ],
      ),
    );
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }
}
