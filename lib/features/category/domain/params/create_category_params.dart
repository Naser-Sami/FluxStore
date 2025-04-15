class CreateCategoryParams {
  final String name;
  final String description;
  final String imageUrl;

  const CreateCategoryParams({
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {'name': name, 'description': description, 'imageUrl': imageUrl};
  }
}
