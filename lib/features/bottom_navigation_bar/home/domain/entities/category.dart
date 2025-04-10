import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String iconName;

  const Category({
    required this.id,
    required this.name,
    required this.iconName,
  });

  Category copyWith({String? id, String? name, String? iconName}) => Category(
    id: id ?? this.id,
    name: name ?? this.name,
    iconName: iconName ?? this.iconName,
  );

  static Category empty() => const Category(id: '', name: '', iconName: '');

  @override
  String toString() {
    return 'Category(id: $id, name: $name, iconName: $iconName)';
  }

  @override
  List<Object?> get props => [id, name, iconName];
}
