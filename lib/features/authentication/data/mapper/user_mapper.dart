import '/features/authentication/_authentication.dart'
    show UserEntity, UserModel;

class UserMapper {
  // Mapping user entity to user model
  static UserEntity toEntity(UserModel userModel) {
    return UserEntity(
      username: userModel.username,
      email: userModel.email,
      role: userModel.role,
      token: userModel.token, // Assuming token is a string in the UserModel
      refreshToken: userModel.refreshToken,
      expiration: userModel.expiration,
    );
  }

  // Mapping user model to user entity
  static UserModel toModel(UserEntity userEntity) {
    return UserModel(
      username: userEntity.username,
      email: userEntity.email,
      role: userEntity.role,
      token: userEntity.token,
      refreshToken: userEntity.refreshToken,
      expiration: userEntity.expiration,
    );
  }
}
