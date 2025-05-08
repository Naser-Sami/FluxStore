import 'dart:io';

import 'package:dio/dio.dart';

class AddProductReviewParams {
  final String productId;
  final double rating;
  final String description;
  final List<File>? images;

  const AddProductReviewParams({
    required this.productId,
    required this.rating,
    required this.description,
    this.images,
  });

  Future<FormData> toFormData() async {
    final formData = FormData.fromMap({
      'productId': productId,
      'rating': rating,
      'description': description,
    });

    if (images != null && images!.isNotEmpty) {
      final imageFiles = await Future.wait(
        images!.map(
          (file) => MultipartFile.fromFile(file.path, filename: 'detail.jpg'),
        ),
      );

      formData.files.addAll(imageFiles.map((file) => MapEntry('images', file)));
    }

    return formData;
  }
}
