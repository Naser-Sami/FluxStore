import 'package:dartz/dartz.dart';

import '/core/_core.dart' show BaseUseCase, Failure;
import '/features/_features.dart' show IProductRepository;

class DeleteProductUseCase extends BaseUseCase<String, String> {
  final IProductRepository repository;
  DeleteProductUseCase({required this.repository});

  @override
  Future<Either<Failure<String>, String>> call(String id) async {
    try {
      return await repository.deleteProduct(id);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
