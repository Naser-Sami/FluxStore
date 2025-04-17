import 'package:equatable/equatable.dart';

import 'product_model.dart';
import 'review_model.dart';

class ProductDetailsModel extends Equatable {
  final ProductModel product;
  final String categoryName;
  final double averageRating;
  final List<ReviewModel> reviews;

  const ProductDetailsModel({
    required this.product,
    required this.categoryName,
    required this.averageRating,
    required this.reviews,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      product: ProductModel.fromJson(json['product']),
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
      'product': product.toJson(),
      'categoryName': categoryName,
      'averageRating': averageRating,
      'reviews': reviews.map((review) => review.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [product, categoryName, averageRating, reviews];
}
