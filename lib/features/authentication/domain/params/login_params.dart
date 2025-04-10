import 'package:equatable/equatable.dart';

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  // toMap
  Map<String, dynamic> toMap() {
    return {'email': email, 'password': password};
  }

  @override
  List<Object?> get props => [email, password];
}
