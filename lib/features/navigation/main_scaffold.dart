import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart' show StatefulNavigationShell;

import '/config/_config.dart' show BottomNavigationBarComponent, TRadius;
import '/core/_core.dart'
    show
        BuildContextExtensions,
        OrientationExtension,
        TDeviceUtils,
        scaffoldKey;
import '/features/_features.dart' show FilterDrawer, OnDrawerTapCubit;

class MainScaffold extends StatelessWidget {
  const MainScaffold({
    super.key,
    required this.navigationShell,
    required this.duration,
    required this.scaleAnimation,
    required this.isScrollingDown,
  });

  final StatefulNavigationShell navigationShell;
  final Duration duration;
  final Animation<double> scaleAnimation;
  final bool isScrollingDown;

  @override
  Widget build(BuildContext context) {
    bool isCollapsed = context.watch<OnDrawerTapCubit>().state;

    final isRTL = Directionality.of(context) == TextDirection.rtl;

    double top() {
      double topHeight = context.screenHeight;

      if (context.isLandscape) {
        topHeight *= 0.0;
      } else {
        topHeight *= 0.1;
      }

      return isCollapsed ? 0 : topHeight;
    }

    double left() {
      if (isCollapsed) return 0;
      if (isRTL) return -0.4 * context.screenWidth;

      return 0.6 * context.screenWidth;
    }

    double right() {
      if (isCollapsed) return 0;
      if (isRTL) return 0.6 * context.screenWidth;

      return -0.4 * context.screenWidth;
    }

    return AnimatedPositioned(
      duration: duration,
      top: top(),
      bottom: 0,
      left: left(),
      right: right(),
      child: ScaleTransition(
        scale: scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.circular(TRadius.r40),
          elevation: 10,
          color: context.theme.colorScheme.surface,
          child: ClipRRect(
            borderRadius: _borderRadius(context, isCollapsed),
            child: Scaffold(
              key: scaffoldKey,
              extendBody: true,
              drawerEnableOpenDragGesture: false,
              endDrawerEnableOpenDragGesture: false,
              endDrawer: const FilterDrawer(),
              resizeToAvoidBottomInset: true,
              bottomNavigationBar: bottomNavigationBar(),
              body: navigationShell,
            ),
          ),
        ),
      ),
    );
  }

  Widget? bottomNavigationBar() {
    final showNavBar = navigationShell.currentIndex < 4;

    if (showNavBar && !isScrollingDown) {
      return const BottomNavigationBarComponent();
    }
    return null;
  }

  BorderRadiusGeometry _borderRadius(BuildContext context, bool isCollapsed) =>
      TDeviceUtils.isIOS() && context.screenHeight > 670
          ? BorderRadius.circular(TRadius.r40)
          : isCollapsed
          ? BorderRadius.zero
          : BorderRadius.circular(TRadius.r40);
}
