import 'package:dartz/dartz.dart';

import '/core/_core.dart' show BaseUseCase, Failure, NoParams, PaginatedList;
import '/features/_features.dart'
    show IProductRepository, Product, ProductQueryParameters;

class GetProductsUseCase
    extends BaseUseCase<PaginatedList<Product>, ProductQueryParameters?> {
  final IProductRepository repository;
  GetProductsUseCase({required this.repository});

  @override
  Future<Either<Failure<String>, PaginatedList<Product>>> call(
    ProductQueryParameters? queryParameters,
  ) async {
    try {
      return await repository.getProducts(queryParameters);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
