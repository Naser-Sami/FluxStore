import '/features/_features.dart' show Category, CategoryModel;

class CategoryMapper {
  static Category toEntity(CategoryModel model) =>
      Category(id: model.id, name: model.name, iconName: model.iconName);

  static CategoryModel toModel(Category entity) => CategoryModel(
    id: entity.id,
    name: entity.name,
    iconName: entity.iconName,
  );
}
