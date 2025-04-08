import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/_features.dart' show SignUpUseCase, SignUpParams, UserEntity;

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase signUpUseCase;
  SignUpBloc({required this.signUpUseCase}) : super(SignUpInitial()) {
    on(_signUpButtonPressed);
  }

  Future<void> _signUpButtonPressed(
    SignUpButtonPressed event,
    Emitter<SignUpState> emit,
  ) async {
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
}
