import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart' show CustomAppBar, TRadius;
import '/core/_core.dart' show BuildContextExtensions;
import 'category/add_category.dart';
import 'category/category.dart';
import 'menu_screen.dart';
import 'product/admin_product.dart';

class AdminScreen extends StatefulWidget {
  static const String routeName = '/admin';
  static const String name = 'Admin';
  const AdminScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final ZoomDrawerController _zoomDrawerController = ZoomDrawerController();

  @override
  void initState() {
    super.initState();
  }

  String _appBarTitle() {
    switch (widget.navigationShell.currentIndex) {
      case 0:
        return AdminCategoryScreen.name;
      case 1:
        return AdminProductScreen.name;
      case 2:
        return 'Orders';
      case 3:
        return 'Customers';
      case 4:
        return 'Settings';
      default:
        return 'Admin';
    }
  }

  List<Widget> _appBarActions() {
    switch (widget.navigationShell.currentIndex) {
      case 0:
        return [
          IconButton(
            onPressed: () {
              context.push(
                AdminCategoryScreen.routeName + AddCategoryScreen.routeName,
              );
            },
            icon: const Icon(Icons.add),
          ),
        ];
      default:
        return [];
    }
  }

  bool _shouldShowAppBar(BuildContext context) {
    final location = GoRouter.of(context).state.path;
    print('location-> $location');
    // Only show AppBar when we are exactly on AdminCategoryScreen or AdminProductScreen
    return location == AdminCategoryScreen.routeName ||
        location == AdminProductScreen.routeName;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final color = context.theme.colorScheme;

    return Scaffold(
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: ZoomDrawer(
          mainScreenTapClose: true,
          menuScreenTapClose: true,
          controller: _zoomDrawerController,
          menuScreen: MenuScreen(
            navigationShell: widget.navigationShell,
            zoomDrawerController: _zoomDrawerController,
          ),
          mainScreen: Scaffold(
            appBar:
                _shouldShowAppBar(context)
                    ? CustomAppBar(
                      leading: IconButton(
                        onPressed: () {
                          _zoomDrawerController.toggle!();
                        },
                        icon: const Icon(Icons.menu),
                      ),
                      title: Text(_appBarTitle()),
                      actions: _appBarActions(),
                    )
                    : null,
            body: widget.navigationShell,
          ),
          borderRadius: TRadius.r24,
          showShadow: true,
          angle: 0.0,
          drawerShadowsBackgroundColor: color.surfaceContainerHighest,
          slideWidth: screenWidth * 0.75,
        ),
      ),
    );
  }
}
