import 'package:flutter/material.dart';

import '/config/_config.dart';
import '/core/_core.dart';
import '/features/_features.dart' show DrawerItem;

class DrawerSectionOne extends StatefulWidget {
  const DrawerSectionOne({super.key});

  @override
  State<DrawerSectionOne> createState() => _DrawerSectionOneState();
}

class _DrawerSectionOneState extends State<DrawerSectionOne> {
  final List<DrawerItem> _drawerItems = [
    DrawerItem(
      icon: 'home',
      title: LocaleKeys.DrawerMenu_homePage,
      onTap: () {},
      isSelected: true,
    ),
    DrawerItem(
      icon: 'search',
      title: LocaleKeys.DrawerMenu_discover,
      onTap: () {},
      isSelected: false,
    ),
    DrawerItem(
      icon: 'bag',
      title: LocaleKeys.DrawerMenu_myOrders,
      onTap: () {},
      isSelected: false,
    ),
    DrawerItem(
      icon: 'profile',
      title: LocaleKeys.DrawerMenu_myProfile,
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
