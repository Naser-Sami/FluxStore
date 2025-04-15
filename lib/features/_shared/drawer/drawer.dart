import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart';
import '/core/_core.dart';
import '/features/_features.dart' show InfoCard;
import 'widgets/_widgets.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.navigationShell,
    required this.onItemSelected,
  });
  final StatefulNavigationShell navigationShell;
  final VoidCallback onItemSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TPadding.p16),
      child: SizedBox(
        width: context.screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(flex: 2),
            const InfoCard(),
            const Spacer(),
            DrawerSectionOne(
              navigationShell: navigationShell,
              onItemSelected: onItemSelected,
            ),
            const Spacer(),
            const TextWidget(LocaleKeys.DrawerMenu_otherC),
            const Spacer(),
            DrawerSectionTwo(
              navigationShell: navigationShell,
              onItemSelected: onItemSelected,
            ),
            const Spacer(flex: 2),
            // const LanguagesButtons(),
            // const Spacer(),
            const ThemeButtons(),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
