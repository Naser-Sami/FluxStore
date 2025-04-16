import '/core/_core.dart' show RefreshTokenHandler;

class AuthService {
  final RefreshTokenHandler refreshHandler;

  AuthService(this.refreshHandler);

  Future<bool> tryRefreshToken(String accessToken, String refreshToken) async {
    return await refreshHandler.tryRefreshToken();
  }
}
