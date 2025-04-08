import '/core/_core.dart' show ApiEndpoints, DioService;
import '/features/authentication/_authentication.dart'
    show IAuthenticationRemoteDataSource, LoginParams, UserModel;

class AuthenticationRemoteDataSource
    implements IAuthenticationRemoteDataSource {
  final DioService dioService = DioService();

  @override
  Future<UserModel?> login(LoginParams loginParams) async {
    try {
      final response = await dioService.post<UserModel>(
        path: ApiEndpoints.login,
        data: loginParams.toMap(),
        parser: (data) => UserModel.fromJson(data),
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel?> signUp(signUpParams) async {
    try {
      final response = await dioService.post<UserModel>(
        path: ApiEndpoints.signUp,
        data: signUpParams.toMap(),
        parser: (data) => UserModel.fromJson(data),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
