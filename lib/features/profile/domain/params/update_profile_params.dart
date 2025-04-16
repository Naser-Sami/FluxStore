class UpdateProfileParams {
  final String firstName;
  final String lastName;
  final String gender;
  final String email;
  final String phoneNumber;
  final String imageUrl;
  final String address;

  const UpdateProfileParams({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.email,
    required this.phoneNumber,
    required this.imageUrl,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'email': email,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
      'address': address,
    };
  }
}
