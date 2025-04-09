import 'package:dartz/dartz.dart';

import '/core/_core.dart' show Failure;
import '/features/_features.dart' show Category;

abstract class ICategoriesRepository {
  Future<Either<Failure<String>, List<Category>>> getCategories();
  Future<Either<Failure<String>, Category>> getCategory(int id);
  Future<Either<Failure<String>, Category>> addCategory(Category category);
  Future<Either<Failure<String>, Category>> updateCategory(Category category);
  Future<void> deleteCategory(int id);
  Future<void> deleteAllCategories();
}
