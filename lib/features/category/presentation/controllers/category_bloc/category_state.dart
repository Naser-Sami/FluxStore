part of 'category_bloc.dart';

class CategoryState extends Equatable {
  const CategoryState({
    required this.isLoading,
    required this.isError,
    required this.isSuccess,
    required this.categories,
    required this.category,
  });

  final bool isLoading;
  final bool isError;
  final bool isSuccess;
  final List<Category> categories;
  final Category category;

  CategoryState copyWith({
    bool? isLoading,
    bool? isError,
    bool? isSuccess,
    List<Category>? categories,
    Category? category,
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
      categories: categories ?? this.categories,
      category: category ?? this.category,
    );
  }

  @override
  List<Object> get props => [
    isLoading,
    isError,
    isSuccess,
    categories,
    category,
  ];
}
