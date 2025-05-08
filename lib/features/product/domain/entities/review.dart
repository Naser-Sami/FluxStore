import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String reviewerName;
  final String reviewerImage;
  final String productId;
  final double rating;
  final String description;
  final List<String> images;
  final String date;

  const Review({
    required this.reviewerName,
    required this.reviewerImage,
    required this.productId,
    required this.rating,
    required this.description,
    required this.images,
    required this.date,
  });

  Review copyWith({
    String? reviewerName,
    String? reviewerImage,
    String? productId,
    double? rating,
    String? description,
    List<String>? images,
    String? date,
  }) {
    return Review(
      reviewerName: reviewerName ?? this.reviewerName,
      reviewerImage: reviewerImage ?? this.reviewerImage,
      productId: productId ?? this.productId,
      rating: rating ?? this.rating,
      description: description ?? this.description,
      images: images ?? this.images,
      date: date ?? this.date,
    );
  }

  static Review empty() {
    return const Review(
      reviewerName: '',
      reviewerImage: '',
      productId: '',
      rating: 0.0,
      description: '',
      images: [],
      date: '',
    );
  }

  @override
  String toString() {
    return 'Review(reviewerName: $reviewerName, reviewerImage: $reviewerImage, productId: $productId, rating: $rating, description: $description, images: $images, date: $date)';
  }

  @override
  List<Object?> get props => [
    reviewerName,
    reviewerImage,
    productId,
    rating,
    description,
    images,
    date,
  ];
}
