import '/core/_core.dart' show RefreshTokenHandler;
import '/features/_features.dart' show UserEntity;

class AuthService {
  final RefreshTokenHandler refreshHandler;

  AuthService(this.refreshHandler);

  Future<UserEntity?> tryRefreshToken(
    String accessToken,
    String refreshToken,
  ) async {
    return await refreshHandler.tryRefreshToken();
  }
}
