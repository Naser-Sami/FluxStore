import 'package:flutter/material.dart';

import '/config/_config.dart';
import '/core/_core.dart';
import '/features/_features.dart' show DrawerItem;

class DrawerSectionTwo extends StatefulWidget {
  const DrawerSectionTwo({super.key});

  @override
  State<DrawerSectionTwo> createState() => _DrawerSectionTwoState();
}

class _DrawerSectionTwoState extends State<DrawerSectionTwo> {
  final List<DrawerItem> _drawerItems = [
    DrawerItem(
      icon: 'settings',
      title: LocaleKeys.DrawerMenu_settings,
      onTap: () {},
      isSelected: false,
    ),
    DrawerItem(
      icon: 'mail',
      title: LocaleKeys.DrawerMenu_support,
      onTap: () {},
      isSelected: false,
    ),
    DrawerItem(
      icon: 'info',
      title: LocaleKeys.DrawerMenu_aboutUs,
      onTap: () {},
      isSelected: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme;
    final textStyle = context.textTheme;

    return Column(
      children: [
        for (var item in _drawerItems)
          ClipRRect(
            borderRadius: BorderRadius.circular(TRadius.r10),
            child: ColoredBox(
              color:
                  item.isSelected
                      ? color.primaryContainer.withValues(alpha: 0.30)
                      : Colors.transparent,
              child: OnTapScaler(
                onTap: item.onTap ?? () {},
                child: ListTile(
                  leading: IconWidget(
                    width: 18,
                    height: 18,
                    name: item.icon ?? "",
                    color: color.onSurface,
                  ),
                  title: TextWidget(
                    item.title ?? "",
                    style: textStyle.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
