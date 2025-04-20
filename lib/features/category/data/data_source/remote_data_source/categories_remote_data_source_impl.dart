import '/core/_core.dart' show ApiEndpoints, ApiClient, sl;
import '/features/_features.dart'
    show
        ICategoriesRemoteDataSource,
        CategoryModel,
        CreateCategoryParams,
        UpdateCategoryParams;

class CategoriesRemoteDataSourceImpl implements ICategoriesRemoteDataSource {
  final ApiClient apiClient = sl<ApiClient>();

  @override
  Future<String> create(CreateCategoryParams category) async {
    try {
      final response = await apiClient.post<String>(
        path: ApiEndpoints.category,
        data: category.toMap(),
      );

      if (response == null) return 'Failed to create category';
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> delete(String id) async {
    try {
      final response = await apiClient.delete(
        path: "${ApiEndpoints.category}/$id",
        data: {'id': id},
      );

      if (response == null) return 'Failed to delete category';
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CategoryModel>> getAll() async {
    try {
      final response = await apiClient.get<List<CategoryModel>>(
        path: ApiEndpoints.category,
        parser:
            (data) =>
                (data as List).map((e) => CategoryModel.fromJson(e)).toList(),
      );

      if (response == null) return [];

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CategoryModel> getById(String id) async {
    try {
      final response = await apiClient.get<CategoryModel>(
        path: ApiEndpoints.category,
        parser: (data) => CategoryModel.fromJson(data),
      );

      return response ?? CategoryModel.empty();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> update(UpdateCategoryParams category) async {
    try {
      final response = await apiClient.put<String>(
        path: "${ApiEndpoints.category}/${category.id}",
        data: category.toMap(),
      );

      if (response == null) return 'Failed to update category';
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
