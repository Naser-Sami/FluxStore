import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final bool? isSelected;

  const Category({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.isSelected,
  });

  Category copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    bool? isSelected,
  }) => Category(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    imageUrl: imageUrl ?? this.imageUrl,
    isSelected: isSelected ?? this.isSelected,
  );

  static Category empty() => const Category(
    id: '',
    name: '',
    description: '',
    imageUrl: '',
    isSelected: false,
  );

  @override
  String toString() {
    return 'Category(id: $id, name: $name, description:$description, imageUrl: $imageUrl, isSelected: $isSelected)';
  }

  @override
  List<Object?> get props => [id, name, description, imageUrl, isSelected];
}
