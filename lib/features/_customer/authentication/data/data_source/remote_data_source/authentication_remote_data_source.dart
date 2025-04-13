import '../../../_authentication.dart'
    show
        LoginParams,
        SignUpParams,
        ResetPasswordParams,
        ForgotPasswordParams,
        UserModel;

abstract class IAuthenticationRemoteDataSource {
  Future<UserModel?> login(LoginParams params);
  Future<UserModel?> signUp(SignUpParams params);
  Future<String?> forgotPassword(ForgotPasswordParams params);
  Future<String?> resetPassword(ResetPasswordParams params);
}
