import 'package:dartz/dartz.dart';

import '/core/_core.dart' show Failure, PaginatedList;
import '/features/_features.dart'
    show
        AddProductParams,
        AddProductReviewParams,
        IProductRemoteDataSource,
        IProductRepository,
        Product,
        ProductDetails,
        ProductDetailsMapper,
        ProductMapper,
        ProductQueryParameters,
        UpdateProductParams;

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
      await remoteDataSource.deleteProduct(id);
      return const Right('Product deleted successfully');
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
  Future<Either<Failure<String>, PaginatedList<Product>>> getProducts(
    ProductQueryParameters? queryParameters,
  ) async {
    try {
      final result = await remoteDataSource.getProducts(queryParameters);

      final data = PaginatedList<Product>(
        items: result.items.map(ProductMapper.toDomain).toList(),
        totalCount: result.totalCount,
      );

      return Right(data);
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
  Future<Either<Failure<String>, Product>> updateProduct(
    UpdateProductParams p,
  ) async {
    try {
      final result = await remoteDataSource.updateProduct(p);
      final resultEntity = ProductMapper.toDomain(result);

      return Right(resultEntity);
    } on Failure catch (e) {
      return Left(Failure(statusCode: e.statusCode, error: e.error));
    } catch (e) {
      return Left(Failure(statusCode: 500, error: e.toString()));
    }
  }
}
