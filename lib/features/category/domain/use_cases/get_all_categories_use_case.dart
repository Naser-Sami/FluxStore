import 'package:dartz/dartz.dart';

import '/core/_core.dart' show BaseUseCase, Failure, NoParams;
import '/features/_features.dart' show Category, ICategoriesRepository;

class GetAllCategoriesUseCase extends BaseUseCase<List<Category>, NoParams> {
  final ICategoriesRepository repository;
  GetAllCategoriesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Category>>> call(NoParams p) async {
    try {
      return await repository.getAll();
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
