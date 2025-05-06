class CartItemModel {
  final String productId;
  final String productName;
  final String imageUrl;
  final double unitPrice;
  final int quantity;
  final double total;
  final String? selectedColor;
  final String? selectedSize;

  CartItemModel({
    required this.productId,
    required this.productName,
    required this.imageUrl,
    required this.unitPrice,
    required this.quantity,
    required this.total,
    this.selectedColor,
    this.selectedSize,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    double parseDouble(dynamic value) {
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    return CartItemModel(
      productId: json['productId'],
      productName: json['productName'],
      imageUrl: json['imageUrl'],
      unitPrice: parseDouble(json['unitPrice']),
      quantity: json['quantity'],
      total: parseDouble(json['total']),
      selectedColor: json['selectedColor'],
      selectedSize: json['selectedSize'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'imageUrl': imageUrl,
      'unitPrice': unitPrice,
      'quantity': quantity,
      'total': total,
      'selectedColor': selectedColor,
      'selectedSize': selectedSize,
    };
  }
}
