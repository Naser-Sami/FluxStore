import '/core/_core.dart'
    show ApiClient, ApiEndpoints, Constants, SecureStorageService, sl;
import '/features/_features.dart';

class RefreshTokenHandler {
  final SecureStorageService _storage = sl<SecureStorageService>();
  final ApiClient _dio = sl<ApiClient>();

  RefreshTokenHandler();

  Future<UserEntity?> tryRefreshToken() async {
    final refreshToken = await _storage.read(key: Constants.keyRefreshToken);
    final accessToken = await _storage.read(key: Constants.keyAccessToken);

    ApiEndpoints.accessToken = accessToken;
    ApiEndpoints.refreshToken = refreshToken;

    // if (refreshToken == null || accessToken == null) return false;
    if (refreshToken == null) return null;

    try {
      final response = await _dio.post<UserModel>(
        path: ApiEndpoints.refresh,
        data: {'refreshToken': refreshToken},
        parser: (data) => UserModel.fromJson(data),
      );

      final newAccessToken = response?.token ?? "";
      final newRefreshToken = response?.refreshToken ?? "";

      await _storage.write(
        key: Constants.keyAccessToken,
        value: newAccessToken,
      );
      await _storage.write(
        key: Constants.keyRefreshToken,
        value: newRefreshToken,
      );

      ApiEndpoints.accessToken = newAccessToken;
      ApiEndpoints.refreshToken = newRefreshToken;

      if (response == null) return null;
      final user = UserMapper.toEntity(response);

      await sl<UserSessionCubit>().clearUser();
      await sl<UserSessionCubit>().saveUser(user);

      return user;
    } catch (_) {
      return null;
    }
  }
}
