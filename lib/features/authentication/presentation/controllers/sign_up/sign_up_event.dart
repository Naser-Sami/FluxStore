part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

final class SignUpButtonPressed extends SignUpEvent {
  final SignUpParams params;
  const SignUpButtonPressed({required this.params});

  @override
  List<Object> get props => [params];
}
