import 'package:dartz/dartz.dart';

import '/core/_core.dart' show Failure;
import '/features/_features.dart'
    show
        Category,
        CategoryMapper,
        ICategoriesRepository,
        ICategoriesRemoteDataSource;

class CategoriesRepositoryImplementation implements ICategoriesRepository {
  final ICategoriesRemoteDataSource categoriesRemoteDataSource;
  CategoriesRepositoryImplementation({
    required this.categoriesRemoteDataSource,
  });

  @override
  Future<Either<Failure<String>, Category>> addCategory(Category category) {
    // TODO: implement addCategory
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAllCategories() {
    // TODO: implement deleteAllCategories
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCategory(int id) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure<String>, List<Category>>> getCategories() async {
    try {
      final result = await categoriesRemoteDataSource.getCategories();
      final resultEntity = result.map(CategoryMapper.toEntity).toList();
      return Right(resultEntity);
    } on Failure catch (e) {
      return Left(Failure(statusCode: e.statusCode, error: e.error));
    } catch (e) {
      return Left(Failure(statusCode: 500, error: e.toString()));
    }
  }

  @override
  Future<Either<Failure<String>, Category>> getCategory(int id) async {
    try {
      final result = await categoriesRemoteDataSource.getCategory(id);
      final resultEntity = CategoryMapper.toEntity(result);
      return Right(resultEntity);
    } on Failure catch (e) {
      return Left(Failure(statusCode: e.statusCode, error: e.error));
    } catch (e) {
      return Left(Failure(statusCode: 500, error: e.toString()));
    }
  }

  @override
  Future<Either<Failure<String>, Category>> updateCategory(Category category) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }
}
