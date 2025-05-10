import 'dart:developer' show log;

import 'package:firebase_messaging/firebase_messaging.dart';

import '/config/routes/_routes.dart' show router;
import '/features/_features.dart' show LoginScreen;
import 'local_notifications_configuration.dart';

class FirebaseMessagingConfiguration {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static late NotificationSettings settings;
  static late String? fcmToken;

  static Future<void> init() async {
    settings = await messaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      fcmToken = await messaging.getToken();
      log('FCM token: $fcmToken');

      // When app is in foreground ( User Local Notifications )
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        await LocalNotificationsConfiguration.showNotification(message);
      });

      // When click on notification ( when app is in background - out of the app )
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        // Navigate to specific screen based on message data if needed
        router.go(LoginScreen.routeName);
      });
    } else {
      fcmToken = null;
    }
  }
}
