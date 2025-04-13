import 'package:equatable/equatable.dart';

class ResetPasswordParams extends Equatable {
  final String token;
  final String email;
  final String newPassword;
  final String confirmNewPassword;

  const ResetPasswordParams({
    required this.token,
    required this.email,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  // toMap
  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'email': email,
      'newPassword': newPassword,
      'confirmPassword': confirmNewPassword,
    };
  }

  @override
  List<Object?> get props => [token, email, newPassword, confirmNewPassword];
}
