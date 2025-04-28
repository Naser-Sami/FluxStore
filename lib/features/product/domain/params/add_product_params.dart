class AddProductParams {
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final int stock;
  final String categoryId;
  final List<String>? additionalImages;
  final List<String>? availableColors;
  final List<String>? availableSizes;

  const AddProductParams({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.stock,
    required this.categoryId,
    required this.additionalImages,
    required this.availableColors,
    required this.availableSizes,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'stock': stock,
      'categoryId': categoryId,
      'additionalImages': additionalImages ?? [],
      'availableColors': availableColors ?? [],
      'availableSizes': availableSizes ?? [],
    };
  }
}
