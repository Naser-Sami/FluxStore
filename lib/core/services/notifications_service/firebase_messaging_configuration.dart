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

      // When app is in background
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        handleNotification(data: message.data);
      });

      // When app is terminated
      messaging.getInitialMessage().then((RemoteMessage? messaging) {
        if (messaging != null) {
          // messaging.data['route'] = CreateAccountScreen.routeName;
          handleNotification(data: messaging.data);
        }
      });
    } else {
      fcmToken = null;
    }
  }
}
