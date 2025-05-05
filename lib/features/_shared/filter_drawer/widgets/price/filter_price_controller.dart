import 'package:flutter_bloc/flutter_bloc.dart';

class FilterPriceCubit extends Cubit<FilterPriceState> {
  FilterPriceCubit() : super(const FilterPriceState(min: 0, max: 0));

  void init(double min, double max) {
    emit(FilterPriceState(min: min, max: max));
  }

  void updatePriceRange(double min, double max) {
    emit(FilterPriceState(min: min, max: max));
  }

  void reset(double min, double max) {
    emit(FilterPriceState(min: min, max: max));
  }
}

class FilterPriceState {
  final double min;
  final double max;

  const FilterPriceState({required this.min, required this.max});

  FilterPriceState copyWith({double? min, double? max}) {
    return FilterPriceState(min: min ?? this.min, max: max ?? this.max);
  }
}
