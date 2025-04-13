import '/features/_features.dart' show CategoryModel;

abstract class ICategoriesRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<CategoryModel> getCategory(int id);
  Future<CategoryModel> addCategory(CategoryModel category);
  Future<CategoryModel> updateCategory(CategoryModel category);
  Future<void> deleteCategory(int id);
  Future<void> deleteAllCategories();
}
