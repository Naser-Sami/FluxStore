import '/core/_core.dart'
    show ApiClient, ApiEndpoints, Constants, SecureStorageService, sl;

class RefreshTokenHandler {
  final SecureStorageService _storage = sl<SecureStorageService>();
  final ApiClient _dio = sl<ApiClient>();

  RefreshTokenHandler();

  Future<bool> tryRefreshToken() async {
    final refreshToken = await _storage.read(key: Constants.keyRefreshToken);
    final accessToken = await _storage.read(key: Constants.keyToken);

    ApiEndpoints.accessToken = accessToken;
    ApiEndpoints.refreshToken = refreshToken;

    if (refreshToken == null || accessToken == null) return false;

    try {
      final response = await _dio.post(
        path: ApiEndpoints.refresh,
        data: {'token': accessToken, 'refreshToken': refreshToken},
      );

      final newAccessToken = response['token'];
      final newRefreshToken = response['refreshToken'];

      await _storage.write(key: Constants.keyToken, value: newAccessToken);
      await _storage.write(
        key: Constants.keyRefreshToken,
        value: newRefreshToken,
      );

      ApiEndpoints.accessToken = newAccessToken;
      ApiEndpoints.refreshToken = newRefreshToken;

      return true;
    } catch (_) {
      return false;
    }
  }
}
