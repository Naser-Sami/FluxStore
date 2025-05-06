import 'package:dartz/dartz.dart';

import '/core/_core.dart' show Failure;
import '/features/_features.dart'
    show AddToCartParams, Cart, RemoveFromCartParams, UpdateCartParams;

abstract class ICartRepository {
  Future<Either<Failure<String>, Cart>> getCart(String userId);
  Future<Either<Failure<String>, String>> addToCart(AddToCartParams param);
  Future<Either<Failure<String>, String>> removeFromCart(
    RemoveFromCartParams param,
  );
  Future<Either<Failure<String>, String>> updateCart(UpdateCartParams param);
}
