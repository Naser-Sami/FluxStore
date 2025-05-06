class UserModel {
  final String token;
  final String refreshToken;
  final String email;
  final String username;
  final String role;
  final String id;

  const UserModel({
    required this.token,
    required this.refreshToken,
    required this.email,
    required this.username,
    required this.role,
    required this.id,
  });

  // fromJson
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token'] ?? "",
      refreshToken: json['refreshToken'] ?? "",
      email: json['email'] ?? "",
      username: json['username'] ?? "",
      role: json['role'] ?? "Customer",
      id: json['userId'] ?? "",
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'refreshToken': refreshToken,
      'email': email,
      'username': username,
      'role': role,
      'userId': id,
    };
  }
}
