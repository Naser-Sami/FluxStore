import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/admin/_admin.dart' show ProductImage;

class ProductSubImagesCubit extends Cubit<List<ProductImage>> {
  ProductSubImagesCubit() : super([]);

  void addFile(File file) {
    emit([...state, ProductImage.file(file)]);
  }

  void addUrl(String url) {
    emit([...state, ProductImage.url(url)]);
  }

  void removeImage(ProductImage image) {
    emit(state.where((i) => i != image).toList());
  }

  void clear() {
    emit([]);
  }
}
