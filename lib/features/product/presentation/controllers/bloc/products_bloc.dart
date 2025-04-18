import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_store/core/use_cases/base_use_case.dart';
import 'package:flux_store/features/_features.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final AddProductUseCase addProductUseCase;
  final GetProductsUseCase getProductsUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  final GetProductByIdUseCase getProductByIdUseCase;
  final GetProductDetailsUseCase getProductDetailsUseCase;
  final AddReviewUseCase addReviewUseCase;

  ProductsBloc({
    required this.addProductUseCase,
    required this.getProductsUseCase,
    required this.updateProductUseCase,
    required this.deleteProductUseCase,
    required this.getProductByIdUseCase,
    required this.getProductDetailsUseCase,
    required this.addReviewUseCase,
  }) : super(ProductsInitial()) {
    on(_addProduct);
    on(_getProducts);
    on(_updateProduct);
    on(_deleteProduct);
    on(_getProductById);
    on(_getProductDetails);
    on(_addReview);
  }

  void _addProduct(AddProductEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    try {
      final addResult = await addProductUseCase(event.params);

      if (addResult.isLeft()) {
        addResult.fold((failure) => emit(ProductsError(failure.error)), (_) {});
        return;
      }

      final result = await getProductsUseCase(const NoParams());
      result.fold(
        (failure) => emit(ProductsError(failure.error)),
        (products) => emit(ProductsLoaded(products)),
      );
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  void _getProducts(GetProductsEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    try {
      final result = await getProductsUseCase(const NoParams());

      result.fold(
        (failure) => emit(ProductsError(failure.error)),
        (products) => emit(ProductsLoaded(products)),
      );
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  void _updateProduct(
    UpdateProductEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    try {
      final updateResult = await updateProductUseCase(event.params);

      if (updateResult.isLeft()) {
        updateResult.fold(
          (failure) => emit(ProductsError(failure.error)),
          (_) {},
        );
        return;
      }

      final result = await getProductsUseCase(const NoParams());
      result.fold(
        (failure) => emit(ProductsError(failure.error)),
        (products) => emit(ProductsLoaded(products)),
      );
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  void _deleteProduct(
    DeleteProductEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    try {
      final deleteResult = await deleteProductUseCase(event.productId);

      if (deleteResult.isLeft()) {
        deleteResult.fold(
          (failure) => emit(ProductsError(failure.error)),
          (_) {},
        );
        return;
      }

      final result = await getProductsUseCase(const NoParams());
      result.fold(
        (failure) => emit(ProductsError(failure.error)),
        (products) => emit(ProductsLoaded(products)),
      );
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  void _getProductById(
    GetProductByIdEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    try {
      final result = await getProductByIdUseCase(event.productId);

      result.fold(
        (failure) => emit(ProductsError(failure.error)),
        (product) => emit(ProductLoaded(product)),
      );
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  void _getProductDetails(
    GetProductDetailsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    try {
      final result = await getProductDetailsUseCase(event.productId);

      result.fold(
        (failure) => emit(ProductsError(failure.error)),
        (productDetails) => emit(ProductDetailsLoaded(productDetails)),
      );
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  void _addReview(AddReviewEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    try {
      final addResult = await addReviewUseCase(event.params);

      if (addResult.isLeft()) {
        addResult.fold((failure) => emit(ProductsError(failure.error)), (_) {});
        return;
      }

      final result = await getProductDetailsUseCase(event.params.productId);
      result.fold(
        (failure) => emit(ProductsError(failure.error)),
        (productDetails) => emit(ProductDetailsLoaded(productDetails)),
      );
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}
