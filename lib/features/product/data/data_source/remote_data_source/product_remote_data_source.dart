import '/core/_core.dart' show PaginatedList;
import '/features/_features.dart'
    show
        AddProductParams,
        AddProductReviewParams,
        ProductDetailsModel,
        ProductModel,
        ProductQueryParameters,
        ReviewModel,
        UpdateProductParams;

abstract class IProductRemoteDataSource {
  Future<PaginatedList<ProductModel>> getProducts(
    ProductQueryParameters? queryParameters,
  );
  Future<ProductModel> getProductById(String id);
  Future<ProductModel> addProduct(AddProductParams params);
  Future<ProductModel> updateProduct(UpdateProductParams params);
  Future<void> deleteProduct(String id);
  Future<ProductDetailsModel> getProductDetails(String id);
  Future<ReviewModel> addReview(AddProductReviewParams params);
}
