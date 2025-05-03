import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' show StatefulNavigationShell;

import '/features/_features.dart' show CustomDrawer;

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({
    super.key,
    required this.slideAnimation,
    required this.menuScaleAnimation,
    required this.navigationShell,
    required this.onItemSelected,
  });

  final Animation<Offset> slideAnimation;
  final Animation<double> menuScaleAnimation;
  final StatefulNavigationShell navigationShell;
  final VoidCallback onItemSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SlideTransition(
          position: slideAnimation,
          child: ScaleTransition(
            scale: menuScaleAnimation,
            child: CustomDrawer(
              navigationShell: navigationShell,
              onItemSelected: onItemSelected,
            ),
          ),
        ),
      ),
    );
  }
}
