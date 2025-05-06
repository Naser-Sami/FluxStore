import '/features/_features.dart' show CartItem, CartItemModel;

class CartItemMapper {
  static CartItem toDomain(CartItemModel cartItemModel) {
    return CartItem(
      productId: cartItemModel.productId,
      productName: cartItemModel.productName,
      imageUrl: cartItemModel.imageUrl,
      unitPrice: cartItemModel.unitPrice,
      quantity: cartItemModel.quantity,
      total: cartItemModel.total,
    );
  }

  static CartItemModel toModel(CartItem cartItem) {
    return CartItemModel(
      productId: cartItem.productId,
      productName: cartItem.productName,
      imageUrl: cartItem.imageUrl,
      unitPrice: cartItem.unitPrice,
      quantity: cartItem.quantity,
      total: cartItem.total,
    );
  }
}
