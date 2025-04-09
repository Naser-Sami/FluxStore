part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

final class GetAllCategoryEvent extends CategoryEvent {}

final class GetCategoryByIdEvent extends CategoryEvent {
  final int id;
  const GetCategoryByIdEvent({required this.id});
  @override
  List<Object> get props => [id];
}
