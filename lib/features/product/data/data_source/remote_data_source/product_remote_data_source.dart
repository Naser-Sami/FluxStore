import '/features/_features.dart'
    show
        AddProductParams,
        UpdateProductParams,
        AddProductReviewParams,
        ProductModel,
        ProductDetailsModel;

abstract class IProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProductById(String id);
  Future<ProductModel> addProduct(AddProductParams params);
  Future<String> updateProduct(UpdateProductParams params);
  Future<String> deleteProduct(String id);
  Future<ProductDetailsModel> getProductsDetailsById(String id);
  Future<String> addProductReview(AddProductReviewParams params);

  // TODO : Add this on the api
  // Future<List<ProductModel>> searchProducts(String query);
  // Future<List<ProductModel>> getProductsByCategory(String category);
}
