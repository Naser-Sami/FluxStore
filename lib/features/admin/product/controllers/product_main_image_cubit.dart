import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/admin/_admin.dart' show ProductImage;

class ProductMainImageCubit extends Cubit<ProductImage> {
  ProductMainImageCubit() : super(ProductImage.file(null));

  void setImageFile(File file) => emit(ProductImage.file(file));

  void setImageUrl(String url) => emit(ProductImage.url(url));

  void clearImage() => emit(ProductImage.file(null));
}
