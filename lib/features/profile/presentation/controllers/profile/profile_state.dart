part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState({required this.profile});
  final Profile profile;

  @override
  List<Object> get props => [profile];
}

class InitialState extends ProfileState {
  const InitialState({required super.profile});
}

class LoadingState extends ProfileState {
  const LoadingState({required super.profile});
}

class LoadedState extends ProfileState {
  const LoadedState({required super.profile});
}

class ErrorState extends ProfileState {
  const ErrorState({required super.profile, required this.error});
  final String error;

  @override
  List<Object> get props => [profile, error];
}
