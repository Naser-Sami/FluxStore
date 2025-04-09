import 'package:flutter/material.dart' show VoidCallback;

class DrawerItem {
  final String icon;
  final String title;
  final VoidCallback? onTap;
  final bool isSelected;

  DrawerItem({
    required this.icon,
    required this.title,
    this.onTap,
    this.isSelected = false,
  });

  DrawerItem copyWith({bool? isSelected}) {
    return DrawerItem(
      icon: icon,
      title: title,
      onTap: onTap,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
