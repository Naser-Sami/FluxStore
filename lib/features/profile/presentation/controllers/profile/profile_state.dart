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

class ProfileLoadingState extends ProfileState {
  const ProfileLoadingState({required super.profile});
}

class ProfileLoadedState extends ProfileState {
  const ProfileLoadedState({required super.profile});
}

class ProfileErrorState extends ProfileState {
  const ProfileErrorState({required super.profile, required this.error});
  final String error;

  @override
  List<Object> get props => [profile, error];
}
