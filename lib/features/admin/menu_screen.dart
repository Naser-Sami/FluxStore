import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart' show OnTapScaler, TPadding, TRadius, TSize;
import '/core/_core.dart' show BuildContextExtensions;
import '/features/_features.dart' show InfoCard;

class MenuItem extends Equatable {
  final bool isSelected;
  final String title;
  final IconData icon;
  final int navigationShellIndex;

  const MenuItem({
    required this.isSelected,
    required this.title,
    required this.icon,
    required this.navigationShellIndex,
  });

  MenuItem copyWith({
    bool? isSelected,
    String? title,
    IconData? icon,
    int? navigationShellIndex,
  }) {
    return MenuItem(
      isSelected: isSelected ?? this.isSelected,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      navigationShellIndex: navigationShellIndex ?? this.navigationShellIndex,
    );
  }

  @override
  List<Object?> get props => [isSelected, title, icon, navigationShellIndex];
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({
    super.key,
    required this.navigationShell,
    required this.zoomDrawerController,
  });

  final StatefulNavigationShell navigationShell;
  final ZoomDrawerController zoomDrawerController;

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<MenuItem> data = [
    const MenuItem(
      isSelected: true,
      title: 'Categories',
      icon: Icons.category_outlined,
      navigationShellIndex: 0,
    ),
    const MenuItem(
      isSelected: false,
      title: 'Products',
      icon: Icons.shopping_cart_outlined,
      navigationShellIndex: 1,
    ),
    const MenuItem(
      isSelected: false,
      title: 'Orders',
      icon: Icons.home_outlined,
      navigationShellIndex: 2,
    ),
    const MenuItem(
      isSelected: false,
      title: 'Customers',
      icon: Icons.person_outlined,
      navigationShellIndex: 3,
    ),
  ];

  @override
  void initState() {
    super.initState();
    data.first.copyWith(isSelected: true);
  }

  Future<void> _toggleSelected(int index) async {
    setState(() {
      data = data.map((e) => e.copyWith(isSelected: false)).toList();
      data[index] = data[index].copyWith(isSelected: true);
    });

    await Future.delayed(const Duration(milliseconds: 300));
    widget.zoomDrawerController.close!();
  }

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme;
    final textStyle = context.textTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(
            start: TPadding.p24,
            bottom: TPadding.p24,
            top: TPadding.p24,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: TSize.s48),
              OnTapScaler(onTap: () async {}, child: const InfoCard()),
              const SizedBox(height: TSize.s24),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final item = data[index];
                    return Stack(
                      key: const ValueKey('MenuItem-'),
                      children: [
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 300),
                          height: 56,
                          width: item.isSelected ? screenWidth * 0.55 : 0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(TRadius.r10),
                            child: ColoredBox(
                              color:
                                  item.isSelected
                                      ? color.primaryContainer.withValues(
                                        alpha: 0.30,
                                      )
                                      : Colors.transparent,
                            ),
                          ),
                        ),
                        OnTapScaler(
                          onTap: () {
                            _toggleSelected(index);

                            widget.navigationShell.goBranch(
                              index,
                              initialLocation:
                                  index == widget.navigationShell.currentIndex,
                            );
                          },
                          child: ListTile(
                            leading: Icon(item.icon),
                            title: Text(
                              item.title.toString(),
                              style: textStyle.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(TPadding.p24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: TSize.s24,
                  children: [
                    const Divider(),
                    OnTapScaler(
                      onTap: () {},
                      child: Row(
                        children: [
                          const Icon(Icons.logout_outlined),
                          const SizedBox(width: TSize.s16),
                          Text(
                            'Logout',
                            style: textStyle.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text('Version 1.0.0', style: textStyle.bodySmall),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
