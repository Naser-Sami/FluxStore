import 'package:equatable/equatable.dart';

class SignUpParams extends Equatable {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;
  final int role;

  const SignUpParams({
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
    this.role = 0,
  });

  // toMap
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'role': role,
    };
  }

  @override
  List<Object?> get props => [username, email, password, confirmPassword, role];
}
