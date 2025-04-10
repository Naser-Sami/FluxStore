import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String iconName;
  final bool? isSelected;

  const Category({
    required this.id,
    required this.name,
    required this.iconName,
    this.isSelected,
  });

  Category copyWith({
    String? id,
    String? name,
    String? iconName,
    bool? isSelected,
  }) => Category(
    id: id ?? this.id,
    name: name ?? this.name,
    iconName: iconName ?? this.iconName,
    isSelected: isSelected ?? this.isSelected,
  );

  static Category empty() =>
      const Category(id: '', name: '', iconName: '', isSelected: false);

  @override
  String toString() {
    return 'Category(id: $id, name: $name, iconName: $iconName, isSelected: $isSelected)';
  }

  @override
  List<Object?> get props => [id, name, iconName, isSelected];
}
