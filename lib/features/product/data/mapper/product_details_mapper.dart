import '/features/_features.dart'
    show ProductDetails, ProductDetailsModel, ProductMapper, ReviewMapper;

class ProductDetailsMapper {
  static ProductDetails toDomain(ProductDetailsModel model) {
    return ProductDetails(
      product: ProductMapper.toDomain(model.product),
      categoryName: model.categoryName,
      averageRating: model.averageRating,
      reviews: model.reviews.map(ReviewMapper.toDomain).toList(),
    );
  }

  static ProductDetailsModel toModel(ProductDetails product) {
    return ProductDetailsModel(
      product: ProductMapper.toModel(product.product),
      categoryName: product.categoryName,
      averageRating: product.averageRating,
      reviews: product.reviews.map(ReviewMapper.toModel).toList(),
    );
  }
}
