import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String reviewerName;
  final String text;
  final String date;
  final double rating;
  final String imageUrl;

  const Review({
    required this.reviewerName,
    required this.text,
    required this.date,
    required this.rating,
    required this.imageUrl,
  });

  Review copyWith({
    String? reviewerName,
    String? text,
    String? date,
    double? rating,
    String? imageUrl,
  }) {
    return Review(
      reviewerName: reviewerName ?? this.reviewerName,
      text: text ?? this.text,
      date: date ?? this.date,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  static Review empty() {
    return const Review(
      reviewerName: '',
      text: '',
      date: '',
      rating: 0.0,
      imageUrl: '',
    );
  }

  @override
  String toString() {
    return 'Review(reviewerName: $reviewerName, text: $text, date: $date, rating: $rating, imageUrl: $imageUrl)';
  }

  @override
  List<Object?> get props => [reviewerName, text, date, rating, imageUrl];
}
