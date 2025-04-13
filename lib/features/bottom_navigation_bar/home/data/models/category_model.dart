import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  CategoryModel copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
  }) => CategoryModel(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    imageUrl: imageUrl ?? this.imageUrl,
  );

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      imageUrl: json['imageUrl'] ?? "",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  factory CategoryModel.empty() =>
      const CategoryModel(id: "", name: '', description: '', imageUrl: '');

  @override
  String toString() {
    return 'CategoryModel(id: $id, name: $name, description: $description, imageUrl: $imageUrl)';
  }

  @override
  List<Object?> get props => [id, name, description, imageUrl];
}
