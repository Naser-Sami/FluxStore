import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String phoneNumber;
  final String imageUrl;
  final String address;

  const Profile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.phoneNumber,
    required this.imageUrl,
    required this.address,
  });

  Profile copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? gender,
    String? phoneNumber,
    String? imageUrl,
    String? address,
  }) {
    return Profile(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      imageUrl: imageUrl ?? this.imageUrl,
      address: address ?? this.address,
    );
  }

  static Profile empty() => const Profile(
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
    return 'Profile(id: $id, firstName: $firstName, lastName: $lastName, email: $email, gender: $gender, phoneNumber: $phoneNumber, imageUrl: $imageUrl, address: $address)';
  }

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    email,
    gender,
    phoneNumber,
    imageUrl,
    address,
  ];
}
