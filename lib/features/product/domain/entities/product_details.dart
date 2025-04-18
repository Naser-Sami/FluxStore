import 'package:equatable/equatable.dart';

import 'review.dart';

class ProductDetails extends Equatable {
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
  final String categoryName;
  final double averageRating;
  final List<Review> reviews;

  const ProductDetails({
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
    required this.categoryName,
    required this.averageRating,
    required this.reviews,
  });

  ProductDetails copyWith({
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
    String? categoryName,
    double? averageRating,
    List<Review>? reviews,
  }) {
    return ProductDetails(
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
      categoryName: categoryName ?? this.categoryName,
      averageRating: averageRating ?? this.averageRating,
      reviews: reviews ?? this.reviews,
    );
  }

  factory ProductDetails.empty() {
    return const ProductDetails(
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
      categoryName: '',
      averageRating: 0.0,
      reviews: [],
    );
  }

  @override
  String toString() {
    return 'ProductDetails(id: $id, name: $name, description: $description, price: $price, imageUrl: $imageUrl, stock: $stock, categoryId: $categoryId, createdAt: $createdAt, additionalImages: $additionalImages, availableColors: $availableColors, availableSizes: $availableSizes, categoryName: $categoryName, averageRating: $averageRating, reviews: $reviews)';
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
    categoryName,
    averageRating,
    reviews,
  ];
}
