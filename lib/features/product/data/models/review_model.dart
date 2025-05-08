import 'package:equatable/equatable.dart';

class ReviewModel extends Equatable {
  final String reviewerName;
  final String reviewerImage;
  final String productId;
  final double rating;
  final String description;
  final List<String> images;
  final String date;

  const ReviewModel({
    required this.reviewerName,
    required this.reviewerImage,
    required this.productId,
    required this.rating,
    required this.description,
    required this.images,
    required this.date,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      reviewerName: json['reviewerName'] as String,
      reviewerImage: json['reviewerImage'] as String,
      productId: json['productId'] as String,
      rating: (json['rating'] as num).toDouble(),
      description: json['description'] as String,
      images: List<String>.from(json['images'] as List<dynamic>),
      date: json['date'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reviewerName': reviewerName,
      'reviewerImage': reviewerImage,
      'productId': productId,
      'rating': rating,
      'description': description,
      'images': images,
      'date': date,
    };
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
