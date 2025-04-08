import 'package:flutter/material.dart';

import '/config/_config.dart';
import '/core/_core.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key, required this.onMenuPressed});
  final VoidCallback onMenuPressed;

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      leading: IconButton(
        icon: IconWidget(
          name: 'menu',
          color: context.theme.colorScheme.onSurface,
        ),
        onPressed: onMenuPressed,
      ),
      title: const TextWidget('Flux Store'),
      actions: [
        IconButton(
          icon: IconWidget(
            name: 'notifications',
            color: context.theme.colorScheme.onSurface,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }
}
