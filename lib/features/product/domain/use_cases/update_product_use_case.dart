import 'package:dartz/dartz.dart';

import '/core/_core.dart' show BaseUseCase, Failure;
import '/features/_features.dart'
    show IProductRepository, Product, UpdateProductParams;

class UpdateProductUseCase extends BaseUseCase<Product, UpdateProductParams> {
  final IProductRepository repository;
  UpdateProductUseCase({required this.repository});

  @override
  Future<Either<Failure<String>, Product>> call(
    UpdateProductParams params,
  ) async {
    try {
      return await repository.updateProduct(params);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
