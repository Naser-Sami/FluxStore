import 'package:dartz/dartz.dart';

import '/core/_core.dart' show BaseUseCase, Failure;
import '/features/_features.dart' show RemoveFromCartParams, ICartRepository;

class RemoveFromCartUseCase extends BaseUseCase<String, RemoveFromCartParams> {
  final ICartRepository repository;
  RemoveFromCartUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(RemoveFromCartParams p) async =>
      repository.removeFromCart(p);
}
