import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final int stock;
  final String categoryId;
  final String createdAt;
  final List<String> additionalImages;
  final List<String> availableColors;
  final List<String> availableSizes;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.stock,
    required this.categoryId,
    required this.createdAt,
    required this.additionalImages,
    required this.availableColors,
    required this.availableSizes,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      stock: json['stock'] as int,
      categoryId: json['categoryId'] as String,
      createdAt: json['createdAt'] as String,
      additionalImages: List<String>.from(json['additionalImages']),
      availableColors: List<String>.from(json['availableColors']),
      availableSizes: List<String>.from(json['availableSizes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'stock': stock,
      'categoryId': categoryId,
      'createdAt': createdAt,
      'additionalImages': additionalImages,
      'availableColors': availableColors,
      'availableSizes': availableSizes,
    };
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    imageUrl,
    stock,
    categoryId,
    createdAt,
    additionalImages,
    availableColors,
    availableSizes,
  ];
}
