import 'package:local_auth/local_auth.dart';

class LocalAuthenticationService {
  static Future<bool> authenticateWithBiometrics() async {
    final LocalAuthentication auth = LocalAuthentication();
    final bool canAuthenticate =
        await auth.canCheckBiometrics || await auth.isDeviceSupported();

    if (!canAuthenticate) return false;

    final bool authenticated = await auth.authenticate(
      localizedReason: 'Use Face ID or Fingerprint to sign in',
      options: const AuthenticationOptions(
        biometricOnly: true,
        stickyAuth: true,
      ),
    );

    return authenticated;
  }
}
