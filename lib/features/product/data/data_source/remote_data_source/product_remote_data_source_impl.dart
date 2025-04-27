import 'package:dio/dio.dart';

import '/core/_core.dart' show ApiEndpoints, ApiClient, sl;
import '/features/_features.dart'
    show
        IProductRemoteDataSource,
        AddProductParams,
        UpdateProductParams,
        AddProductReviewParams,
        ProductModel,
        ProductDetailsModel,
        UpdateProductImageParams,
        UpdateProductDetailsImagesParams;

class ProductRemoteDataSource implements IProductRemoteDataSource {
  final ApiClient apiClient = sl<ApiClient>();

  @override
  Future<ProductModel> addProduct(AddProductParams params) async {
    try {
      final response = await apiClient.post<ProductModel>(
        path: ApiEndpoints.product,
        data: params.toMap(),
        parser: (data) => ProductModel.fromJson(data),
      );

      if (response == null) {
        throw Exception('Failed to add product');
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> addReview(AddProductReviewParams params) async {
    try {
      final response = await apiClient.post(
        path: ApiEndpoints.productAddReview,
        data: params.toMap(),
        parser: (data) => data,
      );

      if (response != 'Success' || response == null) {
        throw Exception('Failed to add product review');
      }

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> deleteProduct(String id) async {
    try {
      final response = await apiClient.delete(
        path: ApiEndpoints.product,
        data: {'id': id},
        parser: (data) => data,
      );
      if (response == null) {
        throw Exception('Failed to delete product');
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final response = await apiClient.get(
        path: '${ApiEndpoints.product}/$id',
        parser: (data) => ProductModel.fromJson(data),
      );
      if (response == null) {
        throw Exception('Failed to get product by id');
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await apiClient.get(
        path: ApiEndpoints.product,
        parser:
            (data) =>
                (data as List).map((e) => ProductModel.fromJson(e)).toList(),
      );

      if (response == null) {
        throw Exception('Failed to get products');
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductDetailsModel> getProductDetails(String id) async {
    try {
      final response = await apiClient.get(
        path: '${ApiEndpoints.product}/$id/details',
        parser: (data) => ProductDetailsModel.fromJson(data),
      );
      if (response == null) {
        throw Exception('Failed to get product details by id');
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> updateProduct(UpdateProductParams params) async {
    try {
      final response = await apiClient.put(
        path: '${ApiEndpoints.product}/${params.id}',
        data: params.toMap(),
        parser: (data) => data,
      );

      if (response == null) {
        throw Exception('Failed to get product details by id');
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> uploadImage(UpdateProductImageParams params) async {
    try {
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          params.imageUrl.path,
          filename: 'product.jpg',
        ),
      });
      final response = await sl<ApiClient>().post<Map<String, dynamic>>(
        path: ApiEndpoints.productUpdateImages,
        data: formData,
        parser: (data) => data,
      );

      return response?['imageUrl'] ?? '';
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<String>?> uploadImages(
    UpdateProductDetailsImagesParams params,
  ) async {
    try {
      final formData = FormData.fromMap({
        'images': params.imageUrls.map(
          (e) async => await MultipartFile.fromFile(
            e.path,
            filename: 'product-details.jpg',
          ),
        ),
      });

      final response = await sl<ApiClient>().post<Map<String, dynamic>>(
        path: ApiEndpoints.productUpdateDetailsImages,
        data: formData,
        parser: (data) => data,
      );

      if (response == null) {
        throw Exception('Failed to upload product details images');
      }
      return response['additionalImages'] as List<String>;
    } catch (e) {
      rethrow;
    }
  }
}
