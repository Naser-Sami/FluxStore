import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/_features.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(LoginInitial()) {
    on(_login);
  }

  Future<void> _login(OnLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final result = await loginUseCase.call(event.params);
      result.fold(
        (failure) {
          emit(
            LoginFailure(error: failure.error, statusCode: failure.statusCode),
          );
        },
        (user) async {
          emit(LoginSuccess(user: user));
        },
      );
    } catch (e) {
      emit(const LoginFailure(error: "Login error."));
    }
  }
}
