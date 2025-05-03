import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/_config.dart';
import '/core/_core.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    required this.onMenuPressed,
    required this.title,
  });
  final VoidCallback onMenuPressed;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: const Duration(milliseconds: 200),
      duration: const Duration(milliseconds: 1200),
      child: CustomAppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 100,
        leading: IconButton(
          icon: IconWidget(
            name: 'menu',
            color: context.theme.colorScheme.onSurface,
          ),
          onPressed: onMenuPressed,
        ),
        title: title,
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
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
        ],
      ),
    );
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }
}
