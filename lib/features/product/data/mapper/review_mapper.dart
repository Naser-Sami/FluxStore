import '/features/_features.dart' show Review, ReviewModel;

class ReviewMapper {
  static Review toDomain(ReviewModel model) {
    return Review(
      reviewerName: model.reviewerName,
      reviewerImage: model.reviewerImage,
      productId: model.productId,
      rating: model.rating,
      description: model.description,
      images: model.images,
      date: model.date,
    );
  }

  static ReviewModel toModel(Review review) {
    return ReviewModel(
      reviewerName: review.reviewerName,
      reviewerImage: review.reviewerImage,
      productId: review.productId,
      rating: review.rating,
      description: review.description,
      images: review.images,
      date: review.date,
    );
  }
}
