import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/_core.dart' show ISocialSignInService, TFunctions, sl;
import '/features/_features.dart' show SignUpUseCase, SignUpParams, UserEntity;

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase signUpUseCase;
  final _socialAuthService = sl<ISocialSignInService>();

  SignUpBloc({required this.signUpUseCase}) : super(SignUpInitial()) {
    on(_signUp);
    on(_googleAuth);
  }

  Future<void> _signUp(OnSignUpEvent event, Emitter<SignUpState> emit) async {
    emit(SignUpLoading());
    try {
      final result = await signUpUseCase.call(event.params);
      result.fold(
        (failure) {
          emit(
            SignUpFailure(error: failure.error, statusCode: failure.statusCode),
          );
        },
        (user) async {
          emit(SignUpSuccess(user: user));
        },
      );
    } catch (e) {
      emit(const SignUpFailure(error: "Sign up error."));
    }
  }

  Future<void> _googleAuth(
    GoogleAuthEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoading());
    try {
      final password = TFunctions.generateStrongPassword();
      final user = await _socialAuthService.signInWithGoogle();

      final params = SignUpParams(
        username: user.user?.displayName ?? '',
        email: user.user?.email ?? '',
        password: password,
        confirmPassword: password,
      );

      final result = await signUpUseCase.call(params);
      result.fold(
        (failure) {
          emit(
            SignUpFailure(error: failure.error, statusCode: failure.statusCode),
          );
        },
        (user) async {
          emit(SignUpSuccess(user: user));
        },
      );
    } catch (error) {
      emit(SignUpFailure(error: error.toString()));
    }
  }
}
