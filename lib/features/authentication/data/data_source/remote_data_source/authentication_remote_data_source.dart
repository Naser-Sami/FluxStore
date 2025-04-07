import '/core/_core.dart' show ApiEndpoints, DioService;
import '/features/authentication/_authentication.dart'
    show LoginParams, UserModel;

abstract class IAuthenticationRemoteDataSource {
  Future<UserModel?> login(LoginParams loginParams);
}

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
}
