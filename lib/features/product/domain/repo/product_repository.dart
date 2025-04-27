import 'package:dartz/dartz.dart';

import '/core/_core.dart' show Failure;
import '/features/_features.dart'
    show
        AddProductParams,
        AddProductReviewParams,
        Product,
        ProductDetails,
        UpdateProductDetailsImagesParams,
        UpdateProductImageParams,
        UpdateProductParams;

abstract class IProductRepository {
  Future<Either<Failure<String>, List<Product>>> getProducts();
  Future<Either<Failure<String>, Product>> getProductById(String id);
  Future<Either<Failure<String>, Product>> addProduct(AddProductParams p);
  Future<Either<Failure<String>, String>> updateProduct(UpdateProductParams p);
  Future<Either<Failure<String>, String>> deleteProduct(String id);
  Future<Either<Failure<String>, ProductDetails>> getProductDetails(String id);
  Future<Either<Failure<String>, String>> addReview(AddProductReviewParams p);
  Future<Either<Failure<String>, String>> uploadImage(
    UpdateProductImageParams p,
  );
  Future<Either<Failure<String>, List<String>>> uploadImages(
    UpdateProductDetailsImagesParams p,
  );
}
