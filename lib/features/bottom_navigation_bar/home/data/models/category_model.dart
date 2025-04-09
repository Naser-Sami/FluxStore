import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final int id;
  final String name;
  final String image;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });

  CategoryModel copyWith({int? id, String? name, String? image}) =>
      CategoryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
      );

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'image': image};
  }

  factory CategoryModel.empty() =>
      const CategoryModel(id: 0, name: '', image: '');

  @override
  String toString() {
    return 'CategoryModel(id: $id, name: $name, image: $image)';
  }

  @override
  List<Object?> get props => [id, name, image];
}
