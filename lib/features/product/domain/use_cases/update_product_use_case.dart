import 'package:dartz/dartz.dart';

import '/core/_core.dart' show BaseUseCase, Failure;
import '/features/_features.dart' show IProductRepository, UpdateProductParams;

class UpdateProductUseCase extends BaseUseCase<String, UpdateProductParams> {
  final IProductRepository repository;
  UpdateProductUseCase({required this.repository});

  @override
  Future<Either<Failure<String>, String>> call(
    UpdateProductParams params,
  ) async {
    try {
      return await repository.updateProduct(params);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
