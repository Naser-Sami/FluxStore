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
        Review,
        ReviewMapper,
        UpdateProductParams;

class ProductRepository implements IProductRepository {
  final IProductRemoteDataSource dataSource;
  ProductRepository({required this.dataSource});

  @override
  Future<Either<Failure<String>, Product>> addProduct(
    AddProductParams p,
  ) async {
    try {
      final result = await dataSource.addProduct(p);
      final resultEntity = ProductMapper.toDomain(result);

      return Right(resultEntity);
    } on Failure catch (e) {
      return Left(Failure(statusCode: e.statusCode, error: e.error));
    } catch (e) {
      return Left(Failure(statusCode: 500, error: e.toString()));
    }
  }

  @override
  Future<Either<Failure<String>, Review>> addReview(
    AddProductReviewParams p,
  ) async {
    try {
      final result = await dataSource.addReview(p);
      return Right(ReviewMapper.toDomain(result));
    } on Failure catch (e) {
      return Left(Failure(statusCode: e.statusCode, error: e.error));
    } catch (e) {
      return Left(Failure(statusCode: 500, error: e.toString()));
    }
  }

  @override
  Future<Either<Failure<String>, String>> deleteProduct(String id) async {
    try {
      await dataSource.deleteProduct(id);
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
      final result = await dataSource.getProductById(id);
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
      final result = await dataSource.getProducts(queryParameters);

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
      final result = await dataSource.getProductDetails(id);
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
      final result = await dataSource.updateProduct(p);
      final resultEntity = ProductMapper.toDomain(result);

      return Right(resultEntity);
    } on Failure catch (e) {
      return Left(Failure(statusCode: e.statusCode, error: e.error));
    } catch (e) {
      return Left(Failure(statusCode: 500, error: e.toString()));
    }
  }
}
