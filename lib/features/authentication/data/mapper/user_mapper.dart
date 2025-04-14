import '/features/_features.dart' show UserEntity, UserModel;

class UserMapper {
  // Mapping user entity to user model
  static UserEntity toEntity(UserModel userModel) {
    return UserEntity(
      username: userModel.username,
      email: userModel.email,
      role: userModel.role,
      token: userModel.token,
    );
  }

  // Mapping user model to user entity
  static UserModel toModel(UserEntity userEntity) {
    return UserModel(
      username: userEntity.username,
      email: userEntity.email,
      role: userEntity.role,
      token: userEntity.token,
    );
  }
}
