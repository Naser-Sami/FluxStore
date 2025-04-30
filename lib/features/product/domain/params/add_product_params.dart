import 'dart:io';

import 'package:dio/dio.dart';

class AddProductParams {
  final String name;
  final String description;
  final double price;
  final int stock;
  final String categoryId;
  final File image; // main image
  final List<File>? additionalImages; // detail images
  final List<String>? availableColors;
  final List<String>? availableSizes;

  const AddProductParams({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.stock,
    required this.categoryId,
    this.additionalImages,
    this.availableColors,
    this.availableSizes,
  });

  Future<FormData> toFormData() async {
    final formData = FormData.fromMap({
      'name': name,
      'description': description,
      'price': price.toString(),
      'stock': stock.toString(),
      'categoryId': categoryId,
      'availableColors': availableColors ?? [],
      'availableSizes': availableSizes ?? [],
      'imageUrl': await MultipartFile.fromFile(
        image.path,
        filename: 'main.jpg',
      ),
    });

    // Append additionalImages as multiple files
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
