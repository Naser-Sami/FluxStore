class UserModel {
  final String username;
  final String email;
  final int role;
  final String token;
  final String refreshToken;
  final String expiration;

  const UserModel({
    required this.username,
    required this.email,
    required this.role,
    required this.token,
    required this.refreshToken,
    required this.expiration,
  });

  // fromJson
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      email: json['email'],
      role: json['role'],
      token: json['token'],
      refreshToken: json['refreshToken'],
      expiration: json['expiration'],
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'role': role,
      'token': token,
      'refreshToken': refreshToken,
      'expiration': expiration,
    };
  }
}
