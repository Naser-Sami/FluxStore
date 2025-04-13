import '/features/_features.dart' show Category, CategoryModel;

class CategoryMapper {
  static Category toEntity(CategoryModel model) => Category(
    id: model.id,
    name: model.name,
    description: model.description,
    imageUrl: model.imageUrl,
  );

  static CategoryModel toModel(Category entity) => CategoryModel(
    id: entity.id,
    name: entity.name,
    description: entity.description,
    imageUrl: entity.imageUrl,
  );
}
