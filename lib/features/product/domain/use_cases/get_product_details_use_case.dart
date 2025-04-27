import 'package:dartz/dartz.dart';

import '/core/_core.dart' show BaseUseCase, Failure;
import '/features/_features.dart' show IProductRepository, ProductDetails;

class GetProductDetailsUseCase extends BaseUseCase<ProductDetails, String> {
  final IProductRepository repository;
  GetProductDetailsUseCase({required this.repository});

  @override
  Future<Either<Failure<String>, ProductDetails>> call(String id) async {
    try {
      return await repository.getProductDetails(id);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
