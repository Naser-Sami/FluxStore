import 'package:equatable/equatable.dart';

class ResetPasswordParams extends Equatable {
  final String token;
  final String newPassword;
  final String confirmNewPassword;

  const ResetPasswordParams({
    required this.token,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  // toMap
  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'newPassword': newPassword,
      'confirmPassword': confirmNewPassword,
    };
  }

  @override
  List<Object?> get props => [token, newPassword, confirmNewPassword];
}
