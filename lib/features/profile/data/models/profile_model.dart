class ProfileModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String phoneNumber;
  final String imageUrl;
  final String address;

  const ProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.phoneNumber,
    required this.imageUrl,
    required this.address,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? "",
      firstName: json['firstName'] ?? "",
      lastName: json['lastName'] ?? "",
      email: json['email'] ?? "",
      gender: json['gender'] ?? "",
      phoneNumber: json['phoneNumber'] ?? "",
      imageUrl: json['imageUrl'] ?? "",
      address: json['address'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
      'address': address,
    };
  }

  static ProfileModel empty() => const ProfileModel(
    id: '',
    firstName: '',
    lastName: '',
    email: '',
    gender: '',
    phoneNumber: '',
    imageUrl: '',
    address: '',
  );

  @override
  String toString() {
    return 'ProfileModel(id: $id, firstName: $firstName, lastName: $lastName, email: $email, gender: $gender, phoneNumber: $phoneNumber, imageUrl: $imageUrl, address: $address)';
  }
}
