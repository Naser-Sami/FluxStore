import 'package:flutter_bloc/flutter_bloc.dart';

class ProductSizesCubit extends Cubit<List<String>> {
  ProductSizesCubit() : super([]);

  void setSizes(List<String> sizes) {
    emit(sizes);
  }

  void addSize(String size) {
    emit(state..add(size));
  }

  void removeSize(String size) {
    emit(state..remove(size));
  }

  void clearSizes() {
    emit([]);
  }
}
