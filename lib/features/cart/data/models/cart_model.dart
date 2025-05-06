import 'cart_item_model.dart';

class CartModel {
  final List<CartItemModel> items;
  final double subTotal;
  final double shippingCost;
  final double total;

  CartModel({
    required this.items,
    required this.subTotal,
    required this.shippingCost,
    required this.total,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    double parseDouble(dynamic value) {
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    return CartModel(
      items:
          (json['items'] as List)
              .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      subTotal: parseDouble(json['subTotal']),
      shippingCost: parseDouble(json['shippingCost']),
      total: parseDouble(json['total']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items,
      'subTotal': subTotal,
      'shippingCost': shippingCost,
      'total': total,
    };
  }
}
