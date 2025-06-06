import 'package:dartz/dartz.dart';

import '/core/_core.dart' show BaseUseCase, Failure;
import '/features/_features.dart'
    show IProductRepository, AddProductParams, Product;

class AddProductUseCase extends BaseUseCase<Product, AddProductParams> {
  final IProductRepository repository;
  AddProductUseCase({required this.repository});

  @override
  Future<Either<Failure<String>, Product>> call(AddProductParams p) async {
    try {
      return await repository.addProduct(p);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
