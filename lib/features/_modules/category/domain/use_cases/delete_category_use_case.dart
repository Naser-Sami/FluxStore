import 'package:dartz/dartz.dart';

import '/core/_core.dart' show BaseUseCase, Failure;
import '/features/_features.dart' show ICategoriesRepository;

class DeleteCategoryUseCase extends BaseUseCase<String, int> {
  final ICategoriesRepository categoriesRepository;
  DeleteCategoryUseCase({required this.categoriesRepository});

  @override
  Future<Either<Failure, String>> call(int p) async {
    try {
      return await categoriesRepository.delete(p);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
