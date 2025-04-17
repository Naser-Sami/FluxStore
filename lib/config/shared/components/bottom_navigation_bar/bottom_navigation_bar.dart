import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '/config/_config.dart';
import '/core/_core.dart' show BuildContextExtensions;

class BottomNavigationBarComponent extends StatelessWidget {
  const BottomNavigationBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 200),
      duration: const Duration(milliseconds: 1200),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          TPadding.p32,
          0,
          TPadding.p32,
          TPadding.p42,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(TRadius.r20)),
          child: BottomAppBar(
            height: 52,
            // color: context.theme.colorScheme.onTertiaryContainer.withValues(
            //   alpha: 0.9,
            // ),
            padding: EdgeInsets.fromLTRB(
              TPadding.p20,
              context.screenHeight < 670 ? 4 : TPadding.p28,
              TPadding.p20,
              context.screenHeight < 670 ? 4 : 0,
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BottomNavigationBarIconWidget(index: 0, iconName: 'home'),
                BottomNavigationBarIconWidget(index: 1, iconName: 'search'),
                BottomNavigationBarIconWidget(index: 2, iconName: 'bag'),
                BottomNavigationBarIconWidget(index: 3, iconName: 'profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
