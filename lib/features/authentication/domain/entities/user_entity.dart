import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String username;
  final String email;
  final int role;
  final String token;
  final String refreshToken;
  final String expiration;

  const UserEntity({
    required this.username,
    required this.email,
    required this.role,
    required this.token,
    required this.refreshToken,
    required this.expiration,
  });

  // copyWith
  UserEntity copyWith({
    String? username,
    String? email,
    int? role,
    String? token,
    String? refreshToken,
    String? expiration,
  }) {
    return UserEntity(
      username: username ?? this.username,
      email: email ?? this.email,
      role: role ?? this.role,
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      expiration: expiration ?? this.expiration,
    );
  }

  @override
  List<Object?> get props => [
    username,
    email,
    role,
    token,
    refreshToken,
    expiration,
  ];
}
