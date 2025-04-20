import '/features/_features.dart'
    show CategoryModel, CreateCategoryParams, UpdateCategoryParams;

abstract class ICategoriesRemoteDataSource {
  Future<List<CategoryModel>> getAll();
  Future<CategoryModel> getById(String id);
  Future<String> create(CreateCategoryParams params);
  Future<String> update(UpdateCategoryParams category);
  Future<String> delete(String id);
}
