import 'package:dartz/dartz.dart';

import '/core/_core.dart' show BaseUseCase, Failure;
import '/features/_features.dart'
    show IProductRepository, AddProductReviewParams;

class AddReviewUseCase extends BaseUseCase<String, AddProductReviewParams> {
  final IProductRepository productRepository;
  AddReviewUseCase({required this.productRepository});

  @override
  Future<Either<Failure<String>, String>> call(AddProductReviewParams p) async {
    try {
      return await productRepository.addReview(p);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
