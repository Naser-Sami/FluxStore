class UpdateProfileParams {
  final String firstName;
  final String lastName;
  final String gender;
  final String phoneNumber;
  final String imageUrl;
  final String address;

  const UpdateProfileParams({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.phoneNumber,
    required this.imageUrl,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
      'address': address,
    };
  }
}
