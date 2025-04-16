import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/_core.dart' show NoParams;
import '/features/_features.dart'
    show Profile, UpdateProfileParams, GetProfileUseCase, UpdateProfileUseCase;

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;

  ProfileBloc({
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
  }) : super(InitialState(profile: Profile.empty())) {
    on(_getProfile);
    on(_updateProfile);
  }

  void _getProfile(GetProfileEvent event, Emitter<ProfileState> emit) async {
    emit(LoadedState(profile: state.profile));
    final result = await getProfileUseCase(const NoParams());
    result.fold(
      (failure) =>
          emit(ErrorState(profile: state.profile, error: failure.error)),
      (profile) => emit(LoadedState(profile: profile)),
    );
  }

  void _updateProfile(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(LoadedState(profile: state.profile));
    final result = await updateProfileUseCase(event.params);
    result.fold(
      (failure) =>
          emit(ErrorState(profile: state.profile, error: failure.error)),
      (profile) => emit(LoadedState(profile: state.profile)),
    );
  }
}
