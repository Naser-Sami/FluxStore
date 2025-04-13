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

final class CreateCategoryEvent extends CategoryEvent {
  final CreateCategoryParams params;
  const CreateCategoryEvent({required this.params});
  @override
  List<Object> get props => [params];
}

final class UpdateCategoryEvent extends CategoryEvent {
  final UpdateCategoryParams params;
  const UpdateCategoryEvent({required this.params});
  @override
  List<Object> get props => [params];
}

final class DeleteCategoryEvent extends CategoryEvent {
  final int id;
  const DeleteCategoryEvent({required this.id});
  @override
  List<Object> get props => [id];
}
