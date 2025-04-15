import '/features/_features.dart' show Profile, ProfileModel;

class ProfileMapper {
  static Profile toEntity(ProfileModel model) {
    return Profile(
      id: model.id,
      firstName: model.firstName,
      lastName: model.lastName,
      email: model.email,
      gender: model.gender,
      phoneNumber: model.phoneNumber,
      imageUrl: model.imageUrl,
      address: model.address,
    );
  }

  static ProfileModel toModel(Profile domain) {
    return ProfileModel(
      id: domain.id,
      firstName: domain.firstName,
      lastName: domain.lastName,
      email: domain.email,
      gender: domain.gender,
      phoneNumber: domain.phoneNumber,
      imageUrl: domain.imageUrl,
      address: domain.address,
    );
  }
}
