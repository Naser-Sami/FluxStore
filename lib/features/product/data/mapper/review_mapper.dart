import '/features/_features.dart' show Review, ReviewModel;

class ReviewMapper {
  static Review toDomain(ReviewModel model) {
    return Review(
      reviewerName: model.reviewerName,
      text: model.text,
      date: model.date,
      rating: model.rating,
      imageUrl: model.imageUrl,
    );
  }

  static ReviewModel toModel(Review review) {
    return ReviewModel(
      reviewerName: review.reviewerName,
      text: review.text,
      date: review.date,
      rating: review.rating,
      imageUrl: review.imageUrl,
    );
  }
}
