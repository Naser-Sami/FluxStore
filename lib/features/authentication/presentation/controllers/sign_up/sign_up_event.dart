part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

final class OnSignUpEvent extends SignUpEvent {
  final SignUpParams params;
  const OnSignUpEvent({required this.params});

  @override
  List<Object> get props => [params];
}

final class GoogleAuthEvent extends SignUpEvent {
  const GoogleAuthEvent();

  @override
  List<Object> get props => [];
}
