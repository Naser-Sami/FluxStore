import '/features/_features.dart' show Cart, CartModel;
import 'cart_item_mapper.dart';

class CartMapper {
  static Cart toDomain(CartModel cartModel) {
    return Cart(
      items: cartModel.items.map(CartItemMapper.toDomain).toList(),
      subTotal: cartModel.subTotal,
      shippingCost: cartModel.shippingCost,
      total: cartModel.total,
    );
  }

  static CartModel toModel(Cart cart) {
    return CartModel(
      items: cart.items.map(CartItemMapper.toModel).toList(),
      subTotal: cart.subTotal,
      shippingCost: cart.shippingCost,
      total: cart.total,
    );
  }
}
