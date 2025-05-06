class RemoveFromCartParams {
  final String userId;
  final String productId;

  RemoveFromCartParams({required this.userId, required this.productId});

  Map<String, dynamic> toMap() {
    return {'userId': userId, 'productId': productId};
  }
}
