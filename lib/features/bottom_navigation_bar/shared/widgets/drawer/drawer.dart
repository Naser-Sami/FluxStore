import 'package:flutter/material.dart';

import '/config/_config.dart';
import '/core/_core.dart';
import 'widgets/_widgets.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme;
    final textStyle = context.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TPadding.p16),
      child: SizedBox(
        width: context.screenWidth * 0.6,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: TPadding.p32, bottom: TPadding.p48),
              child: InfoCard(),
            ),
            ListTile(
              leading: IconWidget(
                width: 18,
                height: 18,
                name: 'home',
                color: color.onSurface,
              ),
              title: const TextWidget(LocaleKeys.DrawerMenu_homePage),
              onTap: () {},
            ),
            const ThemeButtons(),
          ],
        ),
      ),
    );
  }
}
