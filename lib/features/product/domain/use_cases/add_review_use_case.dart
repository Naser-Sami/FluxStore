import 'package:dartz/dartz.dart';

import '/core/_core.dart' show BaseUseCase, Failure;
import '/features/_features.dart'
    show IProductRepository, AddProductReviewParams;

class AddReviewUseCase extends BaseUseCase<String, AddProductReviewParams> {
  final IProductRepository repository;
  AddReviewUseCase({required this.repository});

  @override
  Future<Either<Failure<String>, String>> call(AddProductReviewParams p) async {
    try {
      return await repository.addReview(p);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
