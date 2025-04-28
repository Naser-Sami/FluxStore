import 'dart:io';

class UpdateProductImageParams {
  final String productId;
  final File file;
  UpdateProductImageParams({required this.productId, required this.file});
}
