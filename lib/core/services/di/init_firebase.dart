import 'package:firebase_auth/firebase_auth.dart';

import '/core/_core.dart';

Future<void> initFirebase() async {
  final firebaseAuth = FirebaseAuth.instance;
  sl.registerLazySingleton<FirebaseAuth>(() => firebaseAuth);

  sl.registerLazySingleton<IFirebaseAuthService>(FirebaseAuthServiceImpl.new);

  sl.registerLazySingleton<ISocialSignInService>(SocialSignInServiceImpl.new);
}
