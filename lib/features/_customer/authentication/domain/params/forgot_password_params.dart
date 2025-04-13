import 'package:equatable/equatable.dart';

class ForgotPasswordParams extends Equatable {
  final String email;

  const ForgotPasswordParams({required this.email});

  // toMap
  Map<String, dynamic> toMap() {
    return {'email': email};
  }

  @override
  List<Object?> get props => [email];
}
