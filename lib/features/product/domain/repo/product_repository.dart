import 'package:dartz/dartz.dart';

import '/core/_core.dart' show Failure, PaginatedList;
import '/features/_features.dart'
    show
        AddProductParams,
        AddProductReviewParams,
        Product,
        ProductDetails,
        ProductQueryParameters,
        Review,
        UpdateProductParams;

abstract class IProductRepository {
  Future<Either<Failure<String>, PaginatedList<Product>>> getProducts(
    ProductQueryParameters? queryParameters,
  );
  Future<Either<Failure<String>, Product>> getProductById(String id);
  Future<Either<Failure<String>, Product>> addProduct(AddProductParams p);
  Future<Either<Failure<String>, Product>> updateProduct(UpdateProductParams p);
  Future<Either<Failure<String>, String>> deleteProduct(String id);
  Future<Either<Failure<String>, ProductDetails>> getProductDetails(String id);
  Future<Either<Failure<String>, Review>> addReview(AddProductReviewParams p);
}
