import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/cart/domain/domain.dart';

class CartCubit extends Cubit<Cart> {
  final GetCartUseCase getCartUseCase;
  final AddToCartUseCase addToCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final UpdateCartUseCase updateCartUseCase;

  CartCubit({
    required this.getCartUseCase,
    required this.addToCartUseCase,
    required this.removeFromCartUseCase,
    required this.updateCartUseCase,
  }) : super(Cart.empty());

  Future<void> getCart(String userId) async {
    final result = await getCartUseCase(userId);

    result.fold((failure) => emit(Cart.empty()), emit);
  }

  void addToCart(AddToCartParams params) async {
    final result = await addToCartUseCase(params);

    result.fold(
      (failure) => emit(Cart.empty()),
      (_) => getCart(params.userId), // re-fetch updated cart
    );
  }

  void removeFromCart(RemoveFromCartParams params) async {
    final result = await removeFromCartUseCase(params);
    result.fold(
      (failure) => emit(Cart.empty()),
      (_) => getCart(params.userId), // refresh cart
    );
  }

  void updateCart(UpdateCartParams params) async {
    final result = await updateCartUseCase(params);
    result.fold((failure) => emit(Cart.empty()), (_) => getCart(params.userId));
  }
}
