import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/_config.dart';
import '/core/_core.dart';

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
              // sl<UserSessionCubit>().logout();
              // context.go(SplashScreen.routeName);

              if (context.locale == const Locale('ar')) {
                context.read<LanguageCubit>().changeLanguage(
                  const Locale('en'),
                  context,
                );
              } else {
                context.read<LanguageCubit>().changeLanguage(
                  const Locale('ar'),
                  context,
                );
              }
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
