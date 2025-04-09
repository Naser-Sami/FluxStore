part of 'category_bloc.dart';

class CategoryState extends Equatable {
  const CategoryState({
    required this.isLoading,
    required this.categories,
    required this.category,
  });

  final bool isLoading;
  final List<Category> categories;
  final Category category;

  CategoryState copyWith({
    bool? isLoading,
    List<Category>? categories,
    Category? category,
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      categories: categories ?? this.categories,
      category: category ?? this.category,
    );
  }

  @override
  List<Object> get props => [isLoading, categories, category];
}
