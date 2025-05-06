import 'package:dartz/dartz.dart';

import '/core/_core.dart' show Failure;
import '/features/_features.dart'
    show
        AddToCartParams,
        Cart,
        CartMapper,
        ICartRemoteDataSource,
        ICartRepository,
        RemoveFromCartParams,
        UpdateCartParams;

class CartRepository extends ICartRepository {
  final ICartRemoteDataSource dataSource;

  CartRepository({required this.dataSource});

  @override
  Future<Either<Failure<String>, String>> addToCart(
    AddToCartParams param,
  ) async {
    try {
      await dataSource.addToCart(param);
      return right("Item added to cart");
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  @override
  Future<Either<Failure<String>, Cart>> getCart(String userId) async {
    try {
      final response = await dataSource.getCart(userId);
      return right(CartMapper.toDomain(response));
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  @override
  Future<Either<Failure<String>, String>> removeFromCart(
    RemoveFromCartParams param,
  ) async {
    try {
      await dataSource.removeFromCart(param);
      return right("Item removed from cart");
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  @override
  Future<Either<Failure<String>, String>> updateCart(
    UpdateCartParams param,
  ) async {
    try {
      await dataSource.updateCart(param);
      return right("Cart updated");
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }
}
