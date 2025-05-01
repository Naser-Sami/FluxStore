import 'dart:io';

class ProductImage {
  final File? file;
  final String? url;

  ProductImage.file(this.file) : url = null;
  ProductImage.url(this.url) : file = null;

  bool get isFile => file != null;
  bool get isUrl => url != null;
}
