part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class LoginButtonPressed extends LoginEvent {
  final LoginParams params;
  const LoginButtonPressed({required this.params});

  @override
  List<Object> get props => [params];
}
