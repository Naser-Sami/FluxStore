import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String username;
  final String email;
  final String role;
  final String token;

  const UserEntity({
    required this.username,
    required this.email,
    required this.role,
    required this.token,
  });

  // copyWith
  UserEntity copyWith({
    String? username,
    String? email,
    String? role,
    String? token,
  }) {
    return UserEntity(
      username: username ?? this.username,
      email: email ?? this.email,
      role: role ?? this.role,
      token: token ?? this.token,
    );
  }

  @override
  List<Object?> get props => [username, email, role, token];
}
