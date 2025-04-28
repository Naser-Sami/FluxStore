import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/use_cases/base_use_case.dart';
import '/features/_features.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final AddProductUseCase addProductUseCase;
  final GetProductsUseCase getProductsUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  final GetProductByIdUseCase getProductByIdUseCase;
  final UploadProductImageUseCase uploadProductImageUseCase;
  final UploadProductImagesUseCase uploadProductImagesUseCase;

  ProductsBloc({
    required this.addProductUseCase,
    required this.getProductsUseCase,
    required this.updateProductUseCase,
    required this.deleteProductUseCase,
    required this.getProductByIdUseCase,
    required this.uploadProductImageUseCase,
    required this.uploadProductImagesUseCase,
  }) : super(ProductsInitial()) {
    on(_addProduct);
    on(_getProducts);
    on(_updateProduct);
    on(_deleteProduct);
    on(_getProductById);
    on(_uploadProductImage);
    on(_uploadProductImages);
  }

  void _addProduct(AddProductEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    try {
      final addResult = await addProductUseCase(event.params);

      addResult.fold(
        (failure) => emit(ProductsError(failure.error)),
        (product) => emit(ProductLoaded(product)),
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
    try {
      // ❌ DO NOT emit ProductsLoading()

      final deleteResult = await deleteProductUseCase(event.productId);

      if (deleteResult.isLeft()) {
        // Handle failure
        deleteResult.fold(
          (failure) => emit(ProductsError(failure.error)),
          (_) {},
        );
        return;
      }

      // ✅ If delete succeeded, update the list
      final currentState = state;
      if (currentState is ProductsLoaded) {
        final updatedProducts = List<Product>.from(currentState.products)
          ..removeWhere((p) => p.id == event.productId);

        emit(ProductsLoaded(updatedProducts));
      }
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

  void _uploadProductImage(
    UpdateProductImageEvent event,
    Emitter<ProductsState> emit,
  ) async {
    final uploadResult = await uploadProductImageUseCase(event.p);

    if (uploadResult.isLeft()) {
      uploadResult.fold(
        (failure) => emit(ProductsError(failure.error)),
        (_) {},
      );
      return;
    }
  }

  void _uploadProductImages(
    UpdateProductImagesEvent event,
    Emitter<ProductsState> emit,
  ) async {
    final uploadResult = await uploadProductImagesUseCase(event.p);

    if (uploadResult.isLeft()) {
      uploadResult.fold(
        (failure) => emit(ProductsError(failure.error)),
        (_) {},
      );
      return;
    }
  }
}
