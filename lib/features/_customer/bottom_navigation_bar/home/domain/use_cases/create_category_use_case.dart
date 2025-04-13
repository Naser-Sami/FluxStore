import 'package:dartz/dartz.dart';

import '/core/_core.dart' show BaseUseCase, Failure;
import '/features/_features.dart'
    show ICategoriesRepository, CreateCategoryParams;

class CreateCategoryUseCase extends BaseUseCase<String, CreateCategoryParams> {
  final ICategoriesRepository categoriesRepository;
  CreateCategoryUseCase({required this.categoriesRepository});

  @override
  Future<Either<Failure, String>> call(CreateCategoryParams p) async {
    try {
      return await categoriesRepository.create(p);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
