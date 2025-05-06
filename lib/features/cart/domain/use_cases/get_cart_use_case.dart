import 'package:dartz/dartz.dart';

import '/core/_core.dart' show BaseUseCase, Failure;
import '/features/_features.dart' show Cart, ICartRepository;

class GetCartUseCase extends BaseUseCase<Cart, int> {
  final ICartRepository repository;
  GetCartUseCase({required this.repository});

  @override
  Future<Either<Failure, Cart>> call(int p) async => repository.getCart(p);
}
