import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedCategoryCubit extends Cubit<String?> {
  SelectedCategoryCubit() : super(null);

  void select(String categoryId) {
    emit(categoryId);
  }

  void clear() {
    emit(null);
  }
}
