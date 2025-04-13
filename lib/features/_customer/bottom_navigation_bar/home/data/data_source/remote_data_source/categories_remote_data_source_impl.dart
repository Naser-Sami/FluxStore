import '/core/_core.dart' show ApiEndpoints, DioService;
import '/features/_features.dart'
    show ICategoriesRemoteDataSource, CategoryModel;

class CategoriesRemoteDataSourceImpl implements ICategoriesRemoteDataSource {
  final DioService dioService = DioService();

  @override
  Future<CategoryModel> addCategory(CategoryModel category) {
    // TODO: implement addCategory
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAllCategories() {
    // TODO: implement deleteAllCategories
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCategory(int id) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await dioService.get<List<CategoryModel>>(
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
  Future<CategoryModel> getCategory(int id) async {
    try {
      final response = await dioService.get<CategoryModel>(
        path: ApiEndpoints.category,
        parser: (data) => CategoryModel.fromJson(data),
      );

      return response ?? CategoryModel.empty();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CategoryModel> updateCategory(CategoryModel category) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }
}
