import '/features/authentication/_authentication.dart'
    show LoginParams, SignUpParams, UserModel;

abstract class IAuthenticationRemoteDataSource {
  Future<UserModel?> login(LoginParams loginParams);
  Future<UserModel?> signUp(SignUpParams signUpParams);
}
