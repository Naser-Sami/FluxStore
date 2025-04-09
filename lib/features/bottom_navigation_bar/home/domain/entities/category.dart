import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final String image;

  const Category({required this.id, required this.name, required this.image});

  Category copyWith({int? id, String? name, String? image}) => Category(
    id: id ?? this.id,
    name: name ?? this.name,
    image: image ?? this.image,
  );

  @override
  String toString() {
    return 'Category(id: $id, name: $name, image: $image)';
  }

  @override
  List<Object?> get props => [id, name, image];
}
