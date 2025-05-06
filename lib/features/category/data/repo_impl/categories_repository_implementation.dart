import 'package:dartz/dartz.dart';

import '/core/_core.dart' show Failure;
import '/features/_features.dart'
    show
        Category,
        CategoryMapper,
        ICategoriesRepository,
        ICategoriesRemoteDataSource,
        CreateCategoryParams,
        UpdateCategoryParams;

class CategoriesRepository implements ICategoriesRepository {
  final ICategoriesRemoteDataSource dataSource;
  CategoriesRepository({required this.dataSource});

  @override
  Future<Either<Failure<String>, String>> create(
    CreateCategoryParams category,
  ) async {
    try {
      final result = await dataSource.create(category);

      return Right(result);
    } on Failure catch (e) {
      return Left(Failure(statusCode: e.statusCode, error: e.error));
    } catch (e) {
      return Left(Failure(statusCode: 500, error: e.toString()));
    }
  }

  @override
  Future<Either<Failure<String>, String>> delete(String id) async {
    try {
      final result = await dataSource.delete(id);

      if (result == 'Category deleted successfully') {
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
  Future<Either<Failure<String>, List<Category>>> getAll() async {
    try {
      final result = await dataSource.getAll();
      final resultEntity = result.map(CategoryMapper.toEntity).toList();
      return Right(resultEntity);
    } on Failure catch (e) {
      return Left(Failure(statusCode: e.statusCode, error: e.error));
    } catch (e) {
      return Left(Failure(statusCode: 500, error: e.toString()));
    }
  }

  @override
  Future<Either<Failure<String>, Category>> getById(String id) async {
    try {
      final result = await dataSource.getById(id);
      final resultEntity = CategoryMapper.toEntity(result);
      return Right(resultEntity);
    } on Failure catch (e) {
      return Left(Failure(statusCode: e.statusCode, error: e.error));
    } catch (e) {
      return Left(Failure(statusCode: 500, error: e.toString()));
    }
  }

  @override
  Future<Either<Failure<String>, String>> update(
    UpdateCategoryParams category,
  ) async {
    try {
      final result = await dataSource.update(category);

      return Right(result);
    } on Failure catch (e) {
      return Left(Failure(statusCode: e.statusCode, error: e.error));
    } catch (e) {
      return Left(Failure(statusCode: 500, error: e.toString()));
    }
  }
}
