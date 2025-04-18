import '/features/_features.dart'
    show ProductDetails, ProductDetailsModel, ReviewMapper;

class ProductDetailsMapper {
  static ProductDetails toDomain(ProductDetailsModel model) {
    return ProductDetails(
      id: model.id,
      name: model.name,
      description: model.description,
      price: model.price,
      imageUrl: model.imageUrl,
      stock: model.stock,
      categoryId: model.categoryId,
      createdAt: model.createdAt,
      additionalImages: model.additionalImages,
      availableColors: model.availableColors,
      availableSizes: model.availableSizes,
      categoryName: model.categoryName,
      averageRating: model.averageRating,
      reviews: model.reviews.map(ReviewMapper.toDomain).toList(),
    );
  }

  static ProductDetailsModel toModel(ProductDetails product) {
    return ProductDetailsModel(
      id: product.id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      stock: product.stock,
      categoryId: product.categoryId,
      createdAt: product.createdAt,
      additionalImages: product.additionalImages,
      availableColors: product.availableColors,
      availableSizes: product.availableSizes,
      categoryName: product.categoryName,
      averageRating: product.averageRating,
      reviews: product.reviews.map(ReviewMapper.toModel).toList(),
    );
  }
}
