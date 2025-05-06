import 'package:dartz/dartz.dart';

import '/core/_core.dart' show BaseUseCase, Failure;
import '/features/_features.dart' show UpdateCartParams, ICartRepository;

class UpdateCartUseCase extends BaseUseCase<String, UpdateCartParams> {
  final ICartRepository repository;
  UpdateCartUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(UpdateCartParams p) async =>
      repository.updateCart(p);
}
