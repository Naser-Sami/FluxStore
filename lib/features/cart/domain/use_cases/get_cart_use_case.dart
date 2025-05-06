import 'package:dartz/dartz.dart';

import '/core/_core.dart' show BaseUseCase, Failure;
import '/features/_features.dart' show Cart, ICartRepository;

class GetCartUseCase extends BaseUseCase<Cart, String> {
  final ICartRepository repository;
  GetCartUseCase({required this.repository});

  @override
  Future<Either<Failure, Cart>> call(String p) async => repository.getCart(p);
}
