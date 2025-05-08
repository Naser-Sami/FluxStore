import 'package:dartz/dartz.dart';

import '/core/_core.dart' show BaseUseCase, Failure;
import '/features/_features.dart'
    show AddProductReviewParams, IProductRepository, Review;

class AddReviewUseCase extends BaseUseCase<Review, AddProductReviewParams> {
  final IProductRepository repository;
  AddReviewUseCase({required this.repository});

  @override
  Future<Either<Failure<String>, Review>> call(AddProductReviewParams p) async {
    try {
      return await repository.addReview(p);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
