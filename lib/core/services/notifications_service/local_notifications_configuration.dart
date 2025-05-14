import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'handel_notification.dart';

class LocalNotificationsConfiguration {
  static final _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static InitializationSettings _initializationSettings() {
    const initializationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    return const InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsIOS,
    );
  }

  static NotificationDetails _notificationDetails() {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'default_channel', // id
      'Default', // title
      channelDescription: 'Default channel for notifications',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );

    const iosPlatformChannelSpecifics = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'custom_sound.caf',
    );

    return const NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics,
    );
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
  final Map<String, dynamic> data = jsonDecode(details.payload!);
  handleNotification(data: data);
}

@pragma('vm:entry-point')
void onDidReceiveBackgroundNotificationResponse(NotificationResponse details) {
  final Map<String, dynamic> data = jsonDecode(details.payload!);
  handleNotification(data: data);
}
