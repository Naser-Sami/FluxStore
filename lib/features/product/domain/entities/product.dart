import 'package:equatable/equatable.dart';

class Product extends Equatable {
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

  const Product({
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

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    int? stock,
    String? categoryId,
    String? createdAt,
    List<String>? additionalImages,
    List<String>? availableColors,
    List<String>? availableSizes,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      stock: stock ?? this.stock,
      categoryId: categoryId ?? this.categoryId,
      createdAt: createdAt ?? this.createdAt,
      additionalImages: additionalImages ?? this.additionalImages,
      availableColors: availableColors ?? this.availableColors,
      availableSizes: availableSizes ?? this.availableSizes,
    );
  }

  static Product empty() {
    return const Product(
      id: '',
      name: '',
      description: '',
      price: 0.0,
      imageUrl: '',
      stock: 0,
      categoryId: '',
      createdAt: '',
      additionalImages: [],
      availableColors: [],
      availableSizes: [],
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, price: $price, imageUrl: $imageUrl, stock: $stock, categoryId: $categoryId, createdAt: $createdAt, additionalImages: $additionalImages, availableColors: $availableColors, availableSizes: $availableSizes)';
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
