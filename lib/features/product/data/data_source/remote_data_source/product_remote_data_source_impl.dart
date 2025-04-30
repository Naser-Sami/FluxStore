import '/core/_core.dart' show ApiEndpoints, ApiClient, sl;
import '/features/_features.dart'
    show
        IProductRemoteDataSource,
        AddProductParams,
        UpdateProductParams,
        AddProductReviewParams,
        ProductModel,
        ProductDetailsModel;

class ProductRemoteDataSource implements IProductRemoteDataSource {
  final ApiClient apiClient = sl<ApiClient>();

  @override
  Future<ProductModel> addProduct(AddProductParams params) async {
    try {
      final formData = await params.toFormData();

      final response = await apiClient.post<ProductModel>(
        path: ApiEndpoints.product,
        data: formData,
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
  Future<void> deleteProduct(String id) async {
    try {
      await apiClient.delete<String>(path: '${ApiEndpoints.product}/$id');
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
}
