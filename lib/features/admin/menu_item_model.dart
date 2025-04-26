import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
