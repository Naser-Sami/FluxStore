import 'package:firebase_auth/firebase_auth.dart';

abstract class ISocialSignInService {
  // SingIn
  Future<UserCredential> signInWithApple();
  Future<UserCredential> signInWithFacebook();
  Future<UserCredential> signInWithGitHub();
  Future<UserCredential> signInWithGoogle();
  Future<UserCredential> signInWithX();

  // SingOut
  Future<void> signOutWithGoogle();
}
