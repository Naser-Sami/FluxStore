import 'package:dartz/dartz.dart';

import '/core/_core.dart' show BaseUseCase, Failure;
import '/features/_features.dart'
    show IProductRepository, UpdateProductDetailsImagesParams;

class UploadProductImagesUseCase
    extends BaseUseCase<List<String>, UpdateProductDetailsImagesParams> {
  final IProductRepository repository;
  UploadProductImagesUseCase({required this.repository});

  @override
  Future<Either<Failure<String>, List<String>>> call(
    UpdateProductDetailsImagesParams p,
  ) async {
    try {
      return await repository.uploadImages(p);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
