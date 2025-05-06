import 'package:equatable/equatable.dart';

import 'cart_item.dart';

class Cart extends Equatable {
  final List<CartItem> items;
  final double subTotal;
  final double shippingCost;
  final double total;

  const Cart({
    required this.items,
    required this.subTotal,
    required this.shippingCost,
    required this.total,
  });

  static Cart empty() =>
      const Cart(items: [], subTotal: 0, shippingCost: 0, total: 0);

  Cart copyWith({
    List<CartItem>? items,
    double? subTotal,
    double? shippingCost,
    double? total,
  }) => Cart(
    items: items ?? this.items,
    subTotal: subTotal ?? this.subTotal,
    shippingCost: shippingCost ?? this.shippingCost,
    total: total ?? this.total,
  );

  @override
  List<Object?> get props => [items, subTotal, shippingCost, total];

  @override
  String toString() {
    return 'Cart(items: $items, subTotal: $subTotal, shippingCost: $shippingCost, total: $total)';
  }
}
