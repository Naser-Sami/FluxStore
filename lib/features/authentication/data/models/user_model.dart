class UserModel {
  final String username;
  final String email;
  final String role;
  final String token;

  const UserModel({
    required this.username,
    required this.email,
    required this.role,
    required this.token,
  });

  // fromJson
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] ?? "",
      email: json['email'] ?? "",
      role: json['role'] ?? "Customer",
      token: json['token'] ?? "",
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {'username': username, 'email': email, 'role': role, 'token': token};
  }
}
