import 'package:equatable/equatable.dart';

class ReviewModel extends Equatable {
  final String reviewerName;
  final String text;
  final String date;
  final double rating;
  final String imageUrl;

  const ReviewModel({
    required this.reviewerName,
    required this.text,
    required this.date,
    required this.rating,
    required this.imageUrl,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      reviewerName: json['reviewerName'] as String,
      text: json['text'] as String,
      date: json['date'] as String,
      rating: (json['rating'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reviewerName': reviewerName,
      'text': text,
      'date': date,
      'rating': rating,
      'imageUrl': imageUrl,
    };
  }

  @override
  List<Object?> get props => [reviewerName, text, date, rating, imageUrl];
}
