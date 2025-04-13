import '/core/_core.dart' show ApiEndpoints, DioService;
import '/features/authentication/_authentication.dart'
    show
        IAuthenticationRemoteDataSource,
        LoginParams,
        SignUpParams,
        ForgotPasswordParams,
        ResetPasswordParams,
        UserModel;

class AuthenticationRemoteDataSource
    implements IAuthenticationRemoteDataSource {
  final DioService dioService = DioService();

  @override
  Future<UserModel?> login(LoginParams params) async {
    try {
      final response = await dioService.post<UserModel>(
        path: ApiEndpoints.login,
        data: params.toMap(),
        parser: (data) => UserModel.fromJson(data),
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel?> signUp(SignUpParams params) async {
    try {
      final response = await dioService.post<UserModel>(
        path: ApiEndpoints.signUp,
        data: params.toMap(),
        parser: (data) => UserModel.fromJson(data),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> forgotPassword(ForgotPasswordParams params) async {
    try {
      final response = await dioService.post<String>(
        path: ApiEndpoints.forgotPassword,
        data: params.toMap(),
        parser: (data) => data,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> resetPassword(ResetPasswordParams params) async {
    try {
      final response = await dioService.post<String>(
        path: ApiEndpoints.resetPassword,
        data: params.toMap(),
        parser: (data) => data,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
