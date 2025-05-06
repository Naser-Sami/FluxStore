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
    return CartModel(
      items: json['items'].map((e) => CartItemModel.fromJson(e)).toList(),
      subTotal: json['subTotal'],
      shippingCost: json['shippingCost'],
      total: json['total'],
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
