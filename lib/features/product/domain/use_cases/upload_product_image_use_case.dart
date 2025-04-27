import 'package:dartz/dartz.dart';

import '/core/_core.dart' show BaseUseCase, Failure;
import '/features/_features.dart'
    show IProductRepository, UpdateProductImageParams;

class UploadProductImageUseCase
    extends BaseUseCase<String, UpdateProductImageParams> {
  final IProductRepository repository;
  UploadProductImageUseCase({required this.repository});

  @override
  Future<Either<Failure<String>, String>> call(
    UpdateProductImageParams p,
  ) async {
    try {
      return await repository.uploadImage(p);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
