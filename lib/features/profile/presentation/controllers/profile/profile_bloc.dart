import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/_core.dart' show NoParams;
import '/features/_features.dart'
    show
        Profile,
        UpdateProfileParams,
        GetProfileUseCase,
        UpdateProfileUseCase,
        UpdateProfileImageUseCase;

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final UpdateProfileImageUseCase updateProfileImageUseCase;

  ProfileBloc({
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
    required this.updateProfileImageUseCase,
  }) : super(InitialState(profile: Profile.empty())) {
    on(_getProfile);
    on(_updateProfile);
    on(_updateProfileImage);
  }

  void _getProfile(GetProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadedState(profile: state.profile));
    final result = await getProfileUseCase(const NoParams());
    result.fold(
      (failure) =>
          emit(ProfileErrorState(profile: state.profile, error: failure.error)),
      (profile) => emit(ProfileLoadedState(profile: profile)),
    );
  }

  void _updateProfile(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoadedState(profile: state.profile));

    final updateProfileResult = await updateProfileUseCase(event.params);
    if (updateProfileResult.isLeft()) {
      updateProfileResult.fold(
        (failure) => emit(
          ProfileErrorState(profile: state.profile, error: failure.error),
        ),
        (_) {},
      );
      return;
    }

    // ✅ Get latest profile data from backend after upload
    final profileResult = await getProfileUseCase(const NoParams());
    profileResult.fold(
      (failure) =>
          emit(ProfileErrorState(profile: state.profile, error: failure.error)),
      (profile) => emit(ProfileLoadedState(profile: profile)),
    );
  }

  void _updateProfileImage(
    UpdateProfileImageEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoadingState(profile: state.profile));

    final uploadResult = await updateProfileImageUseCase(event.file);

    if (uploadResult.isLeft()) {
      uploadResult.fold(
        (failure) => emit(
          ProfileErrorState(profile: state.profile, error: failure.error),
        ),
        (_) {},
      );
      return;
    }

    // ✅ Get latest profile data from backend after upload
    final profileResult = await getProfileUseCase(const NoParams());
    profileResult.fold(
      (failure) =>
          emit(ProfileErrorState(profile: state.profile, error: failure.error)),
      (profile) => emit(ProfileLoadedState(profile: profile)),
    );
  }
}
