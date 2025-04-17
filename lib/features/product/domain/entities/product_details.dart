import 'package:equatable/equatable.dart';

import 'product.dart';
import 'review.dart';

class ProductDetails extends Equatable {
  final Product product;
  final String categoryName;
  final double averageRating;
  final List<Review> reviews;

  const ProductDetails({
    required this.product,
    required this.categoryName,
    required this.averageRating,
    required this.reviews,
  });

  ProductDetails copyWith({
    Product? product,
    String? categoryName,
    double? averageRating,
    List<Review>? reviews,
  }) {
    return ProductDetails(
      product: product ?? this.product,
      categoryName: categoryName ?? this.categoryName,
      averageRating: averageRating ?? this.averageRating,
      reviews: reviews ?? this.reviews,
    );
  }

  factory ProductDetails.empty() {
    return ProductDetails(
      product: Product.empty(),
      categoryName: '',
      averageRating: 0.0,
      reviews: [],
    );
  }

  @override
  String toString() {
    return 'ProductDetails(product: $product, categoryName: $categoryName, averageRating: $averageRating, reviews: $reviews)';
  }

  @override
  List<Object?> get props => [product, categoryName, averageRating, reviews];
}
