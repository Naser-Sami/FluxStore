import '/features/_features.dart' show Product, ProductModel;

class ProductMapper {
  static Product toDomain(ProductModel model) {
    return Product(
      id: model.id,
      name: model.name,
      description: model.description,
      price: model.price,
      imageUrl: model.imageUrl,
      stock: model.stock,
      categoryId: model.categoryId,
      createdAt: model.createdAt,
    );
  }

  static ProductModel toModel(Product entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      price: entity.price,
      imageUrl: entity.imageUrl,
      stock: entity.stock,
      categoryId: entity.categoryId,
      createdAt: entity.createdAt,
    );
  }
}
