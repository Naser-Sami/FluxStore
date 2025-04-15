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
  }) : super(
         ProfileState(
           profile: Profile.empty(),
           error: '',
           statusCode: 0,
           isLoading: false,
         ),
       ) {
    on(_getProfile);
    on(_updateProfile);
  }

  void _getProfile(GetProfileEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await getProfileUseCase(const NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(
          error: failure.error,
          statusCode: failure.statusCode,
          isLoading: false,
        ),
      ),
      (profile) => emit(state.copyWith(profile: profile, isLoading: false)),
    );
  }

  void _updateProfile(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await updateProfileUseCase(event.params);
    result.fold(
      (failure) => emit(
        state.copyWith(
          error: failure.error,
          statusCode: failure.statusCode,
          isLoading: false,
        ),
      ),
      (profile) =>
          emit(state.copyWith(profile: state.profile, isLoading: false)),
    );
  }
}
