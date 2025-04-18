import 'package:dartz/dartz.dart';

import '/core/_core.dart' show BaseUseCase, Failure;
import '/features/_features.dart' show IProductRepository, ProductDetails;

class GetProductDetailsUseCase extends BaseUseCase<ProductDetails, String> {
  final IProductRepository productRepository;
  GetProductDetailsUseCase({required this.productRepository});

  @override
  Future<Either<Failure<String>, ProductDetails>> call(String id) async {
    try {
      return await productRepository.getProductDetails(id);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
