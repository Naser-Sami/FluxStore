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
  List<DrawerItem> _drawerItems = [];

  @override
  void initState() {
    super.initState();
    _drawerItems =
        _drawerItems = [
          DrawerItem(
            icon: 'home',
            title: LocaleKeys.DrawerMenu_homePage,
            isSelected: true,
          ),
          DrawerItem(
            icon: 'search',
            title: LocaleKeys.DrawerMenu_discover,
            isSelected: false,
          ),
          DrawerItem(
            icon: 'bag',
            title: LocaleKeys.DrawerMenu_myOrders,
            isSelected: false,
          ),
          DrawerItem(
            icon: 'profile',
            title: LocaleKeys.DrawerMenu_myProfile,
            isSelected: false,
          ),
        ];
  }

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme;
    final textStyle = context.textTheme;

    return Column(
      children: [
        for (var item in _drawerItems)
          Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                height: 56,
                width: item.isSelected ? context.screenWidth * 0.6 : 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(TRadius.r10),
                  child: ColoredBox(
                    color:
                        item.isSelected
                            ? color.primaryContainer.withValues(alpha: 0.30)
                            : Colors.transparent,
                  ),
                ),
              ),
              OnTapScaler(
                onTap: () {
                  // set all to false
                  for (var i in _drawerItems) {
                    i.isSelected = false;
                  }
                  setState(() {
                    item.isSelected = !item.isSelected;
                  });
                },
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
            ],
          ),
      ],
    );
  }
}
