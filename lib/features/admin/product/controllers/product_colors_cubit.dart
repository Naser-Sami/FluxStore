import 'package:flutter_bloc/flutter_bloc.dart';

class ProductColorsCubit extends Cubit<List<String>> {
  ProductColorsCubit() : super([]);

  void setColors(List<String> colors) {
    emit(colors);
  }

  void addColor(String color) {
    final updatedColors = List<String>.from(state)..add(color);
    emit(updatedColors);
  }

  void removeColor(String color) {
    final updatedColors = List<String>.from(state)..remove(color);
    emit(updatedColors);
  }

  void clearColors() {
    emit([]);
  }
}
