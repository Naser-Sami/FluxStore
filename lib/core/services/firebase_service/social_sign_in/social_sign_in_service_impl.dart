import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '/core/_core.dart' show AuthErrorHandler, ISocialSignInService, sl;

class SocialSignInServiceImpl implements ISocialSignInService {
  final _auth = sl<FirebaseAuth>();

  @override
  Future<UserCredential> signInWithApple() {
    // TODO: implement signInWithApple
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> signInWithGitHub() {
    // TODO: implement signInWithGitHub
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final userCredential = await _auth.signInWithCredential(credential);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw AuthErrorHandler.handle(e);
    } catch (e) {
      throw 'Google sign in failed: ${e.toString()}';
    }
  }

  @override
  Future<UserCredential> signInWithX() {
    // TODO: implement signInWithX
    throw UnimplementedError();
  }

  @override
  Future<void> signOutWithGoogle() async => await GoogleSignIn().signOut();
}
