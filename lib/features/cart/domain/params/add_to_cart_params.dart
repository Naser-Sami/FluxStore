class AddToCartParams {
  final String userId;
  final String productId;
  final int quantity;
  final String? color;
  final String? size;

  AddToCartParams({
    required this.userId,
    required this.productId,
    required this.quantity,
    this.color,
    this.size,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'productId': productId,
      'quantity': quantity,
      if (color != null) 'color': color,
      if (size != null) 'size': size,
    };
  }
}
