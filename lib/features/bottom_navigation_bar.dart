import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart'
    show
        BottomNavigationBarComponent,
        BottomNavigationBarCubit,
        ScrollControllerProvider,
        TRadius;
import '/core/_core.dart';
import '/features/_features.dart'
    show CustomDrawer, MainAppBar, OnDrawerTapCubit;

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

    _scrollController = ScrollController();
    _scrollController.addListener(_handleScroll);
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

  void _toggleDrawer() {
    context.read<OnDrawerTapCubit>().state
        ? _controller.forward()
        : _controller.reverse();
    context.read<OnDrawerTapCubit>().toggleDrawer();
  }

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

  Widget _buildDrawer() {
    return Scaffold(
      body: SafeArea(
        child: SlideTransition(
          position: _slideAnimation,
          child: ScaleTransition(
            scale: _menuScaleAnimation,
            child: CustomDrawer(
              navigationShell: widget.navigationShell,
              onItemSelected: _toggleDrawer,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainScaffold() {
    bool isCollapsed = context.watch<OnDrawerTapCubit>().state;

    final isRTL = Directionality.of(context) == TextDirection.rtl;

    final double top = isCollapsed ? 0 : 0.1 * context.screenWidth;

    final double left =
        isCollapsed
            ? 0
            : isRTL
            ? -0.4 * context.screenWidth
            : 0.6 * context.screenWidth;

    final double right =
        isCollapsed
            ? 0
            : isRTL
            ? 0.6 * context.screenWidth
            : -0.4 * context.screenWidth;

    final showAppBar = widget.navigationShell.currentIndex < 3;
    final showNavBar = widget.navigationShell.currentIndex < 4;

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
            borderRadius:
                TDeviceUtils.isIOS() && context.screenHeight > 670
                    ? BorderRadius.circular(TRadius.r40)
                    : isCollapsed
                    ? BorderRadius.zero
                    : BorderRadius.circular(TRadius.r40),
            child: Scaffold(
              extendBody: true,
              resizeToAvoidBottomInset: true,
              appBar:
                  showAppBar && !_isScrollingDown
                      ? MainAppBar(
                        onMenuPressed: _toggleDrawer,
                        index: widget.navigationShell.currentIndex,
                      )
                      : null,
              bottomNavigationBar:
                  showNavBar && !_isScrollingDown
                      ? const BottomNavigationBarComponent()
                      : null,
              body: widget.navigationShell,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;

    _slideAnimation = Tween<Offset>(
      begin: isRTL ? Offset.zero : const Offset(-1, 0),
      end: isRTL ? Offset.zero : Offset.zero,
    ).animate(_controller);

    return ScrollControllerProvider(
      scrollController: _scrollController,
      child: PopScope(
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
              bool isCollapsed = context.read<OnDrawerTapCubit>().state;

              if (isCollapsed &&
                  ((isRTL && delta < -100) || (!isRTL && delta > 100))) {
                _toggleDrawer(); // open
              }

              if (!isCollapsed &&
                  ((isRTL && delta > 100) || (!isRTL && delta < -100))) {
                _toggleDrawer(); // close
              }
            },
            child: Stack(children: [_buildDrawer(), _buildMainScaffold()]),
          ),
        ),
      ),
    );
  }
}
