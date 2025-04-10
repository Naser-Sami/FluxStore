import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String id;
  final String name;
  final String iconName;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.iconName,
  });

  CategoryModel copyWith({String? id, String? name, String? iconName}) =>
      CategoryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        iconName: iconName ?? this.iconName,
      );

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      iconName: json['iconName'] ?? "",
    );
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'iconName': iconName};
  }

  factory CategoryModel.empty() =>
      const CategoryModel(id: "", name: '', iconName: '');

  @override
  String toString() {
    return 'CategoryModel(id: $id, name: $name, iconName: $iconName)';
  }

  @override
  List<Object?> get props => [id, name, iconName];
}
