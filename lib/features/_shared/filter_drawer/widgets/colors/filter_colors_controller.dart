import 'package:flutter/material.dart' show Color, Colors;
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterColorsController extends Cubit<List<FilterColorsModel>> {
  FilterColorsController() : super([]);

  void init() {
    emit([
      const FilterColorsModel(color: Colors.red, isSelected: false),
      const FilterColorsModel(color: Colors.blue, isSelected: false),
      const FilterColorsModel(color: Colors.green, isSelected: false),
      const FilterColorsModel(color: Colors.yellow, isSelected: false),
      const FilterColorsModel(color: Colors.purple, isSelected: false),
      const FilterColorsModel(color: Colors.orange, isSelected: false),
      const FilterColorsModel(color: Colors.pink, isSelected: false),
      const FilterColorsModel(color: Colors.brown, isSelected: false),
      const FilterColorsModel(color: Colors.grey, isSelected: false),
    ]);
  }

  void selectColor(Color color) {
    final newState =
        state.map((e) {
          if (e.color == color) {
            return e.copyWith(isSelected: !e.isSelected); // Toggle selection
          }
          return e;
        }).toList();

    emit(newState);
  }

  void reset() {
    emit(state.map((e) => e.copyWith(isSelected: false)).toList());
  }
}

class FilterColorsModel {
  final Color color;
  final bool isSelected;

  const FilterColorsModel({required this.color, required this.isSelected});

  FilterColorsModel copyWith({bool? isSelected}) {
    return FilterColorsModel(
      color: color,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
