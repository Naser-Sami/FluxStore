import 'package:dartz/dartz.dart';

import '/core/_core.dart' show Failure;
import '/features/_features.dart'
    show
        IProductRepository,
        Product,
        ProductMapper,
        ProductDetails,
        ProductDetailsMapper,
        AddProductParams,
        UpdateProductParams,
        AddProductReviewParams,
        UpdateProductDetailsImagesParams,
        UpdateProductImageParams,
        IProductRemoteDataSource;

class ProductRepository implements IProductRepository {
  final IProductRemoteDataSource remoteDataSource;
  ProductRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure<String>, Product>> addProduct(
    AddProductParams p,
  ) async {
    try {
      final result = await remoteDataSource.addProduct(p);
      final resultEntity = ProductMapper.toDomain(result);

      return Right(resultEntity);
    } on Failure catch (e) {
      return Left(Failure(statusCode: e.statusCode, error: e.error));
    } catch (e) {
      return Left(Failure(statusCode: 500, error: e.toString()));
    }
  }

  @override
  Future<Either<Failure<String>, String>> addReview(
    AddProductReviewParams p,
  ) async {
    try {
      final result = await remoteDataSource.addReview(p);

      if (result == 'Success') {
        return Right(result);
      } else {
        return Left(Failure(statusCode: 500, error: result));
      }
    } on Failure catch (e) {
      return Left(Failure(statusCode: e.statusCode, error: e.error));
    } catch (e) {
      return Left(Failure(statusCode: 500, error: e.toString()));
    }
  }

  @override
  Future<Either<Failure<String>, String>> deleteProduct(String id) async {
    try {
      final result = await remoteDataSource.deleteProduct(id);

      if (result == 'Product deleted successfully') {
        return Right(result);
      } else {
        return Left(Failure(statusCode: 500, error: result));
      }
    } on Failure catch (e) {
      return Left(Failure(statusCode: e.statusCode, error: e.error));
    } catch (e) {
      return Left(Failure(statusCode: 500, error: e.toString()));
    }
  }

  @override
  Future<Either<Failure<String>, Product>> getProductById(String id) async {
    try {
      final result = await remoteDataSource.getProductById(id);
      final resultEntity = ProductMapper.toDomain(result);

      return Right(resultEntity);
    } on Failure catch (e) {
      return Left(Failure(statusCode: e.statusCode, error: e.error));
    } catch (e) {
      return Left(Failure(statusCode: 500, error: e.toString()));
    }
  }

  @override
  Future<Either<Failure<String>, List<Product>>> getProducts() async {
    try {
      final result = await remoteDataSource.getProducts();
      final resultEntity = result.map(ProductMapper.toDomain).toList();

      return Right(resultEntity);
    } on Failure catch (e) {
      return Left(Failure(statusCode: e.statusCode, error: e.error));
    } catch (e) {
      return Left(Failure(statusCode: 500, error: e.toString()));
    }
  }

  @override
  Future<Either<Failure<String>, ProductDetails>> getProductDetails(
    String id,
  ) async {
    try {
      final result = await remoteDataSource.getProductDetails(id);
      final resultEntity = ProductDetailsMapper.toDomain(result);

      return Right(resultEntity);
    } on Failure catch (e) {
      return Left(Failure(statusCode: e.statusCode, error: e.error));
    } catch (e) {
      return Left(Failure(statusCode: 500, error: e.toString()));
    }
  }

  @override
  Future<Either<Failure<String>, String>> updateProduct(
    UpdateProductParams p,
  ) async {
    try {
      final result = await remoteDataSource.updateProduct(p);

      if (result == 'Product updated successfully') {
        return Right(result);
      } else {
        return Left(Failure(statusCode: 500, error: result));
      }
    } on Failure catch (e) {
      return Left(Failure(statusCode: e.statusCode, error: e.error));
    } catch (e) {
      return Left(Failure(statusCode: 500, error: e.toString()));
    }
  }

  @override
  Future<Either<Failure<String>, String>> uploadImage(
    UpdateProductImageParams p,
  ) async {
    try {
      final result = await remoteDataSource.uploadImage(p);
      if (result == null) {
        return const Left(
          Failure(statusCode: 500, error: 'Failed to upload image'),
        );
      }
      return Right(result);
    } on Failure catch (e) {
      return Left(Failure(statusCode: e.statusCode, error: e.error));
    } catch (e) {
      return Left(Failure(statusCode: 500, error: e.toString()));
    }
  }

  @override
  Future<Either<Failure<String>, List<String>>> uploadImages(
    UpdateProductDetailsImagesParams p,
  ) async {
    try {
      final result = await remoteDataSource.uploadImages(p);
      if (result == null) {
        return const Left(
          Failure(statusCode: 500, error: 'Failed to upload images'),
        );
      }
      return Right(result);
    } on Failure catch (e) {
      return Left(Failure(statusCode: e.statusCode, error: e.error));
    } catch (e) {
      return Left(Failure(statusCode: 500, error: e.toString()));
    }
  }
}
