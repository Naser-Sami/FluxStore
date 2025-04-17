class AddProductReviewParams {
  final String productId;
  final double rating;
  final String text;
  final String imageUrl;

  const AddProductReviewParams({
    required this.productId,
    required this.rating,
    required this.text,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'rating': rating,
      'text': text,
      'imageUrl': imageUrl,
    };
  }
}
