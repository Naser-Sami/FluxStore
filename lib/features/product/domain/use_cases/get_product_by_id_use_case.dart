import 'package:dartz/dartz.dart';

import '/core/_core.dart' show BaseUseCase, Failure;
import '/features/_features.dart' show IProductRepository, Product;

class GetProductByIdUseCase extends BaseUseCase<Product, String> {
  final IProductRepository productRepository;
  GetProductByIdUseCase({required this.productRepository});

  @override
  Future<Either<Failure<String>, Product>> call(String id) async {
    try {
      return await productRepository.getProductById(id);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
