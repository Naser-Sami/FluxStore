import 'package:flutter/material.dart' show VoidCallback;

class DrawerItem {
  String? title;
  String? icon;
  bool isSelected;
  VoidCallback? onTap;
  DrawerItem({this.title, this.icon, this.isSelected = false, this.onTap});
}
