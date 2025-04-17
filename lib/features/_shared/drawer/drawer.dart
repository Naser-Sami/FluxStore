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
    if (context.isLandscape) {
      return SizedBox(
        height: context.screenHeight,
        width: context.screenWidth,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: TSize.s48),
              const InfoCard(),
              const SizedBox(height: TSize.s24),
              DrawerSectionOne(
                navigationShell: navigationShell,
                onItemSelected: onItemSelected,
              ),
              const SizedBox(height: TSize.s24),
              const TextWidget(LocaleKeys.DrawerMenu_otherC),
              const SizedBox(height: TSize.s24),
              DrawerSectionTwo(
                navigationShell: navigationShell,
                onItemSelected: onItemSelected,
              ),
              const SizedBox(height: TSize.s48),
              const ThemeButtons(),
              const SizedBox(height: TSize.s48),
            ],
          ),
        ),
      );
    }
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
            const ThemeButtons(),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
