import 'dart:io';

class UpdateProductDetailsImagesParams {
  final String productId;
  final List<File> imageUrls;

  UpdateProductDetailsImagesParams({
    required this.productId,
    required this.imageUrls,
  });
}
