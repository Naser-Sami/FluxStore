import 'package:dartz/dartz.dart';

import '/core/_core.dart' show BaseUseCase, Failure;
import '/features/_features.dart'
    show ICategoriesRepository, UpdateCategoryParams;

class UpdateCategoryUseCase extends BaseUseCase<String, UpdateCategoryParams> {
  final ICategoriesRepository categoriesRepository;
  UpdateCategoryUseCase({required this.categoriesRepository});

  @override
  Future<Either<Failure, String>> call(UpdateCategoryParams p) async {
    try {
      return await categoriesRepository.update(p);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
