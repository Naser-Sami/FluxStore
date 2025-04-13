import 'package:dartz/dartz.dart';

import '/core/_core.dart' show BaseUseCase, Failure;
import '/features/_features.dart' show Category, ICategoriesRepository;

class GetCategoryUseCase extends BaseUseCase<Category, int> {
  final ICategoriesRepository categoriesRepository;
  GetCategoryUseCase({required this.categoriesRepository});

  @override
  Future<Either<Failure, Category>> call(int id) async {
    try {
      return await categoriesRepository.getCategory(id);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
