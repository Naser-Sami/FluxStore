import 'dart:developer' show log;

import 'package:firebase_messaging/firebase_messaging.dart';

import 'handel_notification.dart';
import 'local_notifications_configuration.dart'
    show LocalNotificationsConfiguration;

class FirebaseMessagingConfiguration {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static late NotificationSettings settings;

  // TODO: FCM token needs to be stored in the server db for each user device
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
        // TODO: Navigate to specific screen based on message data if needed
        handleNotification(data: message.data);
      });
    } else {
      fcmToken = null;
    }
  }
}
