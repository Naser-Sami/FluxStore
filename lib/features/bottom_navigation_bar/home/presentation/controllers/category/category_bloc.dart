import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/_core.dart' show NoParams;
import '/features/_features.dart'
    show Category, GetAllCategoriesUseCase, GetCategoryUseCase;

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetAllCategoriesUseCase getAllCategoriesUseCase;
  final GetCategoryUseCase getCategoryUseCase;

  CategoryBloc({
    required this.getAllCategoriesUseCase,
    required this.getCategoryUseCase,
  }) : super(
         CategoryState(
           isLoading: false,
           categories: [],
           category: Category.empty(),
         ),
       ) {
    on(_getAllCategories);
    on(_getCategory);
  }

  void _getAllCategories(
    GetAllCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await getAllCategoriesUseCase.call(const NoParams());
    result.fold(
      (failure) => emit(state.copyWith(categories: [], isLoading: false)),
      (categories) =>
          emit(state.copyWith(categories: categories, isLoading: false)),
    );
  }

  void _getCategory(
    GetCategoryByIdEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await getCategoryUseCase(event.id);
    result.fold(
      (failure) =>
          emit(state.copyWith(category: Category.empty(), isLoading: false)),
      (category) => emit(state.copyWith(category: category, isLoading: false)),
    );
  }
}
