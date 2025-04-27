import 'package:dartz/dartz.dart';

import '/core/_core.dart' show BaseUseCase, Failure, NoParams;
import '/features/_features.dart' show IProductRepository, Product;

class GetProductsUseCase extends BaseUseCase<List<Product>, NoParams> {
  final IProductRepository repository;
  GetProductsUseCase({required this.repository});

  @override
  Future<Either<Failure<String>, List<Product>>> call(NoParams params) async {
    try {
      return await repository.getProducts();
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
