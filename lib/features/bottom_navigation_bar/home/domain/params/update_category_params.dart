import 'package:equatable/equatable.dart';

class UpdateCategoryParams extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final DateTime updatedAt;

  const UpdateCategoryParams({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [id, name, description, imageUrl, updatedAt];
}
