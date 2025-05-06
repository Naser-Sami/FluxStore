class UpdateCartParams {
  final String userId;
  final String productId;
  final int quantity;

  UpdateCartParams({
    required this.userId,
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {'userId': userId, 'productId': productId, 'quantity': quantity};
  }
}
