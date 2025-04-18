import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/_features.dart'
    show
        AddProductReviewParams,
        AddReviewUseCase,
        GetProductDetailsUseCase,
        ProductDetails;

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final GetProductDetailsUseCase getProductDetailsUseCase;
  final AddReviewUseCase addReviewUseCase;

  ProductDetailsBloc({
    required this.getProductDetailsUseCase,
    required this.addReviewUseCase,
  }) : super(ProductDetailsInitial()) {
    on(_getProductDetails);
    on(_addReview);
  }

  void _getProductDetails(
    GetProductDetailsEvent event,
    Emitter<ProductDetailsState> emit,
  ) async {
    if (state is ProductDetailsLoaded &&
        (state as ProductDetailsLoaded).productDetails.id == event.productId) {
      return;
    }

    emit(ProductDetailsLoading());
    try {
      final result = await getProductDetailsUseCase(event.productId);

      result.fold(
        (failure) => emit(ProductDetailsError(failure.error)),
        (productDetails) => emit(ProductDetailsLoaded(productDetails)),
      );
    } catch (e) {
      emit(ProductDetailsError(e.toString()));
    }
  }

  void _addReview(
    AddReviewEvent event,
    Emitter<ProductDetailsState> emit,
  ) async {
    try {
      final addResult = await addReviewUseCase(event.params);

      if (addResult.isLeft()) {
        addResult.fold(
          (failure) => emit(ProductDetailsError(failure.error)),
          (_) {},
        );
        return;
      }

      final result = await getProductDetailsUseCase(event.params.productId);
      result.fold(
        (failure) => emit(ProductDetailsError(failure.error)),
        (productDetails) => emit(ProductDetailsLoaded(productDetails)),
      );
    } catch (e) {
      emit(ProductDetailsError(e.toString()));
    }
  }
}
