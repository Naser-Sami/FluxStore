import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart'
    show BottomNavigationBarCubit, ScrollControllerProvider;
import '/features/_features.dart' show DrawerCubit, OnDrawerTapCubit;
import 'custom_drawer.dart';
import 'main_scaffold.dart';

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
  final Duration duration = const Duration(milliseconds: 300);

  late final ScrollController _scrollController;
  bool _isScrollingDown = false;

  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _menuScaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();

    _reset();
    _scrollController = ScrollController();
    _scrollController.addListener(_handleScroll);
  }

  void _reset() {
    context.read<BottomNavigationBarCubit>().reset();
    context.read<DrawerCubit>().selectItem(0);
  }

  void _initializeAnimations() {
    _controller = AnimationController(vsync: this, duration: duration);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(_controller);
    _menuScaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(_controller);

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(_controller);
  }

  void _toggleDrawer() => context.read<OnDrawerTapCubit>().toggleDrawer();

  void _handleScroll() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (!_isScrollingDown) {
        setState(() => _isScrollingDown = true);
      }
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (_isScrollingDown) {
        setState(() => _isScrollingDown = false);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;

    _slideAnimation = Tween<Offset>(
      begin: isRTL ? Offset.zero : const Offset(-1, 0),
      end: isRTL ? Offset.zero : Offset.zero,
    ).animate(_controller);

    return MultiBlocListener(
      listeners: [
        BlocListener<OnDrawerTapCubit, bool>(
          listener: (context, state) {
            !state ? _controller.forward() : _controller.reverse();
          },
        ),
        BlocListener<BottomNavigationBarCubit, int>(
          listener: (context, index) {
            widget.navigationShell.goBranch(
              index,
              initialLocation: index == widget.navigationShell.currentIndex,
            );
          },
        ),
      ],
      child: ScrollControllerProvider(
        scrollController: _scrollController,
        child: PopScope(
          canPop: false,
          child: GestureDetector(
            onHorizontalDragStart: _onHorizontalDragStart,
            onHorizontalDragUpdate: _onHorizontalDragUpdate,
            child: Stack(
              children: [
                CustomDrawerWidget(
                  slideAnimation: _slideAnimation,
                  menuScaleAnimation: _menuScaleAnimation,
                  navigationShell: widget.navigationShell,
                  onItemSelected: _toggleDrawer,
                ),
                MainScaffold(
                  navigationShell: widget.navigationShell,
                  duration: duration,
                  scaleAnimation: _scaleAnimation,
                  isScrollingDown: _isScrollingDown,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    dragStartX = details.localPosition.dx;
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;
    final delta = details.localPosition.dx - dragStartX;

    bool isCollapsed = context.read<OnDrawerTapCubit>().state;

    if (isCollapsed && ((isRTL && delta < -100) || (!isRTL && delta > 100))) {
      _toggleDrawer(); // open
    }

    if (!isCollapsed && ((isRTL && delta > 100) || (!isRTL && delta < -100))) {
      _toggleDrawer(); // close
    }
  }
}
