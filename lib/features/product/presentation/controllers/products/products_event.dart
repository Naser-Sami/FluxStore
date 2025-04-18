part of 'products_bloc.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

final class AddProductEvent extends ProductsEvent {
  final AddProductParams params;

  const AddProductEvent(this.params);

  @override
  List<Object> get props => [params];
}

final class GetProductsEvent extends ProductsEvent {
  const GetProductsEvent();

  @override
  List<Object> get props => [];
}

final class UpdateProductEvent extends ProductsEvent {
  final UpdateProductParams params;

  const UpdateProductEvent(this.params);

  @override
  List<Object> get props => [params];
}

final class DeleteProductEvent extends ProductsEvent {
  final String productId;

  const DeleteProductEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

final class GetProductByIdEvent extends ProductsEvent {
  final String productId;

  const GetProductByIdEvent(this.productId);

  @override
  List<Object> get props => [productId];
}
