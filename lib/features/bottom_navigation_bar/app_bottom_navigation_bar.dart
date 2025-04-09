import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart'
    show BottomNavigationBarComponent, BottomNavigationBarCubit, TRadius;
import '/core/_core.dart';
import '/features/_features.dart' show CustomDrawer, MainAppBar;

class AppBottomNavigationBar extends StatefulWidget {
  static const routeName = '/flux-store';
  static const String name = 'Flux Store';

  final StatefulNavigationShell navigationShell;

  const AppBottomNavigationBar({super.key, required this.navigationShell});

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  double dragStartX = 0.0;
  bool isCollapsed = true;
  final Duration duration = const Duration(milliseconds: 300);

  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _menuScaleAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controller = AnimationController(vsync: this, duration: duration);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(_controller);
    _menuScaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(_controller);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(_controller);
  }

  void _toggleDrawer() {
    setState(() {
      isCollapsed ? _controller.forward() : _controller.reverse();
      isCollapsed = !isCollapsed;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDrawer() {
    return Scaffold(
      body: SafeArea(
        child: SlideTransition(
          position: _slideAnimation,
          child: ScaleTransition(
            scale: _menuScaleAnimation,
            child: const CustomDrawer(),
          ),
        ),
      ),
    );
  }

  Widget _buildMainScaffold() {
    final double top = isCollapsed ? 0 : 0.1 * context.screenWidth;
    final double left = isCollapsed ? 0 : 0.6 * context.screenWidth;
    final double right = isCollapsed ? 0 : -0.4 * context.screenWidth;

    return AnimatedPositioned(
      duration: duration,
      top: top,
      bottom: 0,
      left: left,
      right: right,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.circular(TRadius.r40),
          elevation: 10,
          color: context.theme.colorScheme.surface,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(TRadius.r40),
            child: Scaffold(
              extendBody: true,
              resizeToAvoidBottomInset: true,
              appBar:
                  widget.navigationShell.currentIndex != 3
                      ? MainAppBar(onMenuPressed: _toggleDrawer)
                      : null,
              body: widget.navigationShell,
              bottomNavigationBar: const BottomNavigationBarComponent(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocListener<BottomNavigationBarCubit, int>(
        listener: (context, index) {
          widget.navigationShell.goBranch(
            index,
            initialLocation: index == widget.navigationShell.currentIndex,
          );
        },
        child: GestureDetector(
          onHorizontalDragStart: (details) {
            dragStartX = details.localPosition.dx;
          },
          onHorizontalDragUpdate: (details) {
            final delta = details.localPosition.dx - dragStartX;

            // Detect swipe right to open
            if (isCollapsed && delta > 100) {
              _toggleDrawer();
            }

            // Detect swipe left to close
            if (!isCollapsed && delta < -100) {
              _toggleDrawer();
            }
          },
          child: Stack(children: [_buildDrawer(), _buildMainScaffold()]),
        ),
      ),
    );
  }
}
