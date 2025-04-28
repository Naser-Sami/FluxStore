import '/features/_features.dart'
    show
        AddProductParams,
        AddProductReviewParams,
        ProductDetailsModel,
        ProductModel,
        UpdateProductDetailsImagesParams,
        UpdateProductParams,
        UpdateProductImageParams;

abstract class IProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProductById(String id);
  Future<ProductModel> addProduct(AddProductParams params);
  Future<String> updateProduct(UpdateProductParams params);
  Future<void> deleteProduct(String id);
  Future<ProductDetailsModel> getProductDetails(String id);
  Future<String> addReview(AddProductReviewParams params);
  Future<String?> uploadImage(UpdateProductImageParams params);
  Future<List<String>?> uploadImages(UpdateProductDetailsImagesParams params);

  // Add this on the api
  // Future<List<ProductModel>> searchProducts(String query);
  // Future<List<ProductModel>> getProductsByCategory(String category);
}
