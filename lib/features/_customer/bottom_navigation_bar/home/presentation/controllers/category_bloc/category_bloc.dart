import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/_core.dart' show NoParams;
import '/features/_features.dart'
    show
        Category,
        GetAllCategoriesUseCase,
        GetCategoryUseCase,
        CreateCategoryParams,
        UpdateCategoryParams,
        CreateCategoryUseCase,
        UpdateCategoryUseCase,
        DeleteCategoryUseCase;

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetAllCategoriesUseCase getAllCategoriesUseCase;
  final GetCategoryUseCase getCategoryUseCase;
  final CreateCategoryUseCase createCategoryUseCase;
  final UpdateCategoryUseCase updateCategoryUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;

  CategoryBloc({
    required this.getAllCategoriesUseCase,
    required this.getCategoryUseCase,
    required this.createCategoryUseCase,
    required this.updateCategoryUseCase,
    required this.deleteCategoryUseCase,
  }) : super(
         CategoryState(
           isLoading: false,
           isError: false,
           categories: [],
           category: Category.empty(),
         ),
       ) {
    on(_getAllCategories);
    on(_getCategory);
    on(_createCategory);
    on(_updateCategory);
    on(_deleteCategory);
  }

  void _getAllCategories(
    GetAllCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await getAllCategoriesUseCase.call(const NoParams());
    result.fold(
      (failure) =>
          emit(state.copyWith(categories: [], isLoading: false, isError: true)),
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
      (failure) => emit(
        state.copyWith(
          category: Category.empty(),
          isLoading: false,
          isError: true,
        ),
      ),
      (category) => emit(state.copyWith(category: category, isLoading: false)),
    );
  }

  void _createCategory(
    CreateCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await createCategoryUseCase(event.params);
    result.fold(
      (failure) => emit(
        state.copyWith(
          category: Category.empty(),
          isLoading: false,
          isError: true,
        ),
      ),
      (category) => emit(state.copyWith(isLoading: false)),
    );
  }

  void _updateCategory(
    UpdateCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await updateCategoryUseCase(event.params);
    result.fold(
      (failure) => emit(
        state.copyWith(
          category: Category.empty(),
          isLoading: false,
          isError: true,
        ),
      ),
      (category) => emit(state.copyWith(isLoading: false)),
    );
  }

  void _deleteCategory(
    DeleteCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await deleteCategoryUseCase(event.id);
    result.fold(
      (failure) => emit(
        state.copyWith(
          category: Category.empty(),
          isLoading: false,
          isError: true,
        ),
      ),
      (category) => emit(state.copyWith(isLoading: false)),
    );
  }
}
