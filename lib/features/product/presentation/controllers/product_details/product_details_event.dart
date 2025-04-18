part of 'product_details_bloc.dart';

sealed class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();

  @override
  List<Object> get props => [];
}

final class GetProductDetailsEvent extends ProductDetailsEvent {
  final String productId;

  const GetProductDetailsEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

final class AddReviewEvent extends ProductDetailsEvent {
  final AddProductReviewParams params;

  const AddReviewEvent(this.params);

  @override
  List<Object> get props => [params];
}
