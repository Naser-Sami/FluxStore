import 'package:dartz/dartz.dart';

import '/core/_core.dart' show Failure;
import '/features/_features.dart'
    show Category, CreateCategoryParams, UpdateCategoryParams;

abstract class ICategoriesRepository {
  Future<Either<Failure<String>, List<Category>>> getAll();
  Future<Either<Failure<String>, Category>> getById(String id);
  Future<Either<Failure<String>, String>> create(CreateCategoryParams category);
  Future<Either<Failure<String>, String>> update(UpdateCategoryParams category);
  Future<Either<Failure<String>, String>> delete(String id);
}
