part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class OnLoginEvent extends LoginEvent {
  final LoginParams params;
  const OnLoginEvent({required this.params});

  @override
  List<Object> get props => [params];
}

final class BiometricLoginEvent extends LoginEvent {
  const BiometricLoginEvent();

  @override
  List<Object> get props => [];
}
