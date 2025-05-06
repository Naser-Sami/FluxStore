import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final String productId;
  final String productName;
  final String imageUrl;
  final double unitPrice;
  final int quantity;
  final double total;

  const CartItem({
    required this.productId,
    required this.productName,
    required this.imageUrl,
    required this.unitPrice,
    required this.quantity,
    required this.total,
  });

  static CartItem empty() => const CartItem(
    productId: '',
    productName: '',
    imageUrl: '',
    unitPrice: 0,
    quantity: 0,
    total: 0,
  );

  CartItem copyWith({
    String? productId,
    String? productName,
    String? imageUrl,
    double? unitPrice,
    int? quantity,
    double? total,
  }) => CartItem(
    productId: productId ?? this.productId,
    productName: productName ?? this.productName,
    imageUrl: imageUrl ?? this.imageUrl,
    unitPrice: unitPrice ?? this.unitPrice,
    quantity: quantity ?? this.quantity,
    total: total ?? this.total,
  );

  @override
  String toString() {
    return 'CartItem(productId: $productId, productName: $productName, imageUrl: $imageUrl, unitPrice: $unitPrice, quantity: $quantity, total: $total)';
  }

  @override
  List<Object?> get props => [
    productId,
    productName,
    imageUrl,
    unitPrice,
    quantity,
    total,
  ];
}
