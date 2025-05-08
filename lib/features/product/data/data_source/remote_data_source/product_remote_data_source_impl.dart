import '/core/_core.dart' show ApiClient, ApiEndpoints, PaginatedList, sl;
import '/features/_features.dart'
    show
        AddProductParams,
        AddProductReviewParams,
        IProductRemoteDataSource,
        ProductDetailsModel,
        ProductModel,
        ProductQueryParameters,
        ReviewModel,
        UpdateProductParams;

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
  Future<ReviewModel> addReview(AddProductReviewParams params) async {
    try {
      final formData = await params.toFormData();

      final response = await apiClient.post<ReviewModel>(
        path: ApiEndpoints.productAddReview,
        data: formData,
        parser: (data) => ReviewModel.fromJson(data),
      );

      if (response == null) {
        throw Exception('Failed to add review');
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
  Future<PaginatedList<ProductModel>> getProducts(
    ProductQueryParameters? queryParameters,
  ) async {
    try {
      parser(data) => PaginatedList<ProductModel>(
        items:
            (data['items'] as List)
                .map((e) => ProductModel.fromJson(e))
                .toList(),
        totalCount: data['totalCount'],
      );

      final response = await apiClient.get<PaginatedList<ProductModel>>(
        path: ApiEndpoints.product,
        queryParameters: queryParameters?.toMap(),
        parser: parser,
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
  Future<ProductModel> updateProduct(UpdateProductParams params) async {
    try {
      final formData = await params.toFormData();

      final response = await apiClient.put<ProductModel>(
        path: '${ApiEndpoints.product}/${params.id}',
        data: formData,
        parser: (data) => ProductModel.fromJson(data),
      );

      if (response == null) {
        throw Exception('Failed to update product');
      }

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
