import 'package:equatable/equatable.dart';

import 'review_model.dart';

class ProductDetailsModel extends Equatable {
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
  final List<ReviewModel> reviews;

  const ProductDetailsModel({
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

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
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
      categoryName: json['categoryName'] as String,
      averageRating: (json['averageRating'] as num).toDouble(),
      reviews:
          (json['reviews'] as List)
              .map((review) => ReviewModel.fromJson(review))
              .toList(),
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
      'categoryName': categoryName,
      'averageRating': averageRating,
      'reviews': reviews.map((review) => review.toJson()).toList(),
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
    categoryName,
    averageRating,
    reviews,
  ];
}
