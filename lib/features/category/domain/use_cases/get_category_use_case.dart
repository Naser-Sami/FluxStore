import 'package:dartz/dartz.dart';

import '/core/_core.dart' show BaseUseCase, Failure;
import '/features/_features.dart' show Category, ICategoriesRepository;

class GetCategoryUseCase extends BaseUseCase<Category, String> {
  final ICategoriesRepository categoriesRepository;
  GetCategoryUseCase({required this.categoriesRepository});

  @override
  Future<Either<Failure, Category>> call(String id) async {
    try {
      return await categoriesRepository.getById(id);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
