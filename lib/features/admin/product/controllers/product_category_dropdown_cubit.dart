import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCategoryDropdownCubit extends Cubit<String> {
  ProductCategoryDropdownCubit() : super('');

  void setSelectedCategoryId(String? id) => emit(id ?? '');
}
