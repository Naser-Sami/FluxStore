import 'package:dartz/dartz.dart';

import '/core/_core.dart' show BaseUseCase, Failure;
import '/features/_features.dart' show AddToCartParams, ICartRepository;

class AddToCartUseCase extends BaseUseCase<String, AddToCartParams> {
  final ICartRepository repository;
  AddToCartUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(AddToCartParams p) async =>
      repository.addToCart(p);
}
