class DrawerItem {
  final String icon;
  final String title;
  final bool isSelected;

  DrawerItem({
    required this.icon,
    required this.title,
    this.isSelected = false,
  });

  DrawerItem copyWith({bool? isSelected}) {
    return DrawerItem(
      icon: icon,
      title: title,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
