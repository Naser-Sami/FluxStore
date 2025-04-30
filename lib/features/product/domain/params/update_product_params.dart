import 'dart:io';

import 'package:dio/dio.dart';

class UpdateProductParams {
  final String id;
  final String name;
  final String description;
  final double price;
  final File imageUrl;
  final int stock;
  final String categoryId;
  final List<File>? additionalImages;
  final List<String>? availableColors;
  final List<String>? availableSizes;

  const UpdateProductParams({
    required this.id,
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

  Future<FormData> toFormData() async {
    final formData = FormData.fromMap({
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'categoryId': categoryId,
      'availableColors': availableColors ?? [],
      'availableSizes': availableSizes ?? [],
      'imageUrl': await MultipartFile.fromFile(
        imageUrl.path,
        filename: 'main.jpg',
      ),
    });

    if (additionalImages != null && additionalImages!.isNotEmpty) {
      final imageFiles = await Future.wait(
        additionalImages!.map(
          (file) => MultipartFile.fromFile(file.path, filename: 'detail.jpg'),
        ),
      );

      formData.files.addAll(
        imageFiles.map((file) => MapEntry('additionalImages', file)),
      );
    }

    return formData;
  }
}
