import 'dart:convert' show jsonEncode;
import 'dart:developer' show log;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '/config/routes/_routes.dart' show router;
import '/features/_features.dart' show CreateAccountScreen, LoginScreen;

class LocalNotificationsConfiguration {
  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static InitializationSettings _initializationSettings() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );
    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
          macOS: initializationSettingsIOS,
        );

    return initializationSettings;
  }

  static NotificationDetails _notificationDetails() {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'default_channel', // id
          'Default', // title
          channelDescription: 'Default channel for notifications',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: true,
        );

    const DarwinNotificationDetails iosPlatformChannelSpecifics =
        DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          sound: 'custom_sound.caf',
        );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics,
    );

    return platformChannelSpecifics;
  }

  static Future<void> init() async {
    await _flutterLocalNotificationsPlugin.initialize(
      _initializationSettings(),
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
    );
  }

  static Future<void> showNotification(RemoteMessage message) async {
    await _flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      _notificationDetails(),
      payload: jsonEncode(message.data),
    );
  }
}

// When click on the local notification ( inside the app )
@pragma('vm:entry-point')
void onDidReceiveNotificationResponse(NotificationResponse details) {
  log('onDidReceiveNotificationResponse');
  // Handle navigation or logic here
  log('details: $details');
  router.go(LoginScreen.routeName);
}

@pragma('vm:entry-point')
void onDidReceiveBackgroundNotificationResponse(NotificationResponse details) {
  log('onDidReceiveBackgroundNotificationResponse (top-level)');
  // Handle navigation or logic here
  log('details: $details');
  router.go(CreateAccountScreen.routeName);
}
