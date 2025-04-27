import 'dart:developer' show log;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/_core.dart'
    show
        Constants,
        LocalAuthenticationService,
        RefreshTokenHandler,
        SecureStorageService,
        sl;
import '/features/_features.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(LoginInitial()) {
    on(_login);
    on(_biometricLogin);
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

  Future<void> _biometricLogin(
    BiometricLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    try {
      final storage = sl<SecureStorageService>();

      final refreshToken = await storage.read(key: Constants.keyRefreshToken);
      log('Refreshing token: $refreshToken');

      if (refreshToken == null) {
        log('No refresh token found');
        return;
      }

      final isAuthenticated =
          await LocalAuthenticationService.authenticateWithBiometrics();

      if (isAuthenticated) {
        final user = await sl<RefreshTokenHandler>().tryRefreshToken();

        if (user != null) {
          emit(LoginSuccess(user: user));
        }
      }
    } catch (e) {
      emit(const LoginFailure(error: "Biometric login error."));
    }
  }
}
