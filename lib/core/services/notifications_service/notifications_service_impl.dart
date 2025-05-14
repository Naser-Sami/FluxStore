import 'dart:developer' show log;

import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis_auth/auth_io.dart' as auth;

import '/core/_core.dart' show ApiClient, INotificationsService, sl;

class NotificationsServiceImpl implements INotificationsService {
  final ApiClient _apiClient = sl<ApiClient>();

  Future<String> _getAccessToken() async {
    try {
      final jsonString = await rootBundle.loadString(
        'assets/notifications_key/fluxstore-55f10-02d77547870c.json',
      );
      final accountCredentials = auth.ServiceAccountCredentials.fromJson(
        jsonString,
      );
      final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
      final client = await auth.clientViaServiceAccount(
        accountCredentials,
        scopes,
      );

      String accessToken = client.credentials.accessToken.data;
      log('Access token retrieved successfully $accessToken');
      return accessToken;
    } catch (e) {
      log('Error retrieving access token: $e');
      rethrow;
    }
  }

  @override
  Future<void> sendNotification({
    required String fcmToken,
    required String title,
    required String body,
    required Map<String, String> data,
  }) async {
    try {
      final accessToken = await _getAccessToken();

      const String fcmUrl =
          'https://fcm.googleapis.com/v1/projects/fluxstore-55f10/messages:send';

      Map<String, dynamic> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      // This will be returned from the server (backend)
      Map<String, dynamic> notificationPayload = {
        'message': {
          'token': fcmToken,
          'notification': {'title': title, 'body': body},
          'data': data,
          'android': {
            'priority': 'high',
            'notification': {
              'sound': 'custom_sound',
              'channel_id': 'high_importance_channel',
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            },
          },
          'apns': {
            'headers': {'apns-priority': '10'},
            'payload': {
              'aps': {'sound': 'custom_sound.caf', 'content-available': 1},
            },
          },
        },
      };

      final response = await _apiClient.post(
        path: fcmUrl,
        headers: headers,
        data: notificationPayload,
      );

      log('✅ Notification response: $response');
      log('✅ Notification sent successfully to $fcmToken');
    } catch (e) {
      log('❌ Error sending notification: $e');
    }
  }
}

/**
 
 - return the notification payload from the server (backend)

 {
  "message": {
    "token": "FCM_DEVICE_TOKEN",
    "notification": {
      "title": "🛍 New Offer!",
      "body": "Get 20% off your next purchase!"
    },
    "data": {
      "type": "promotion",
      "route": "/offers"
    },
    "android": {
      "priority": "high",
      "notification": {
        "sound": "custom_sound",
        "channel_id": "high_importance_channel",
        "click_action": "FLUTTER_NOTIFICATION_CLICK"
      }
    },
    "apns": {
      "headers": {
        "apns-priority": "10"
      },
      "payload": {
        "aps": {
          "alert": {
            "title": "🛍 New Offer!",
            "body": "Get 20% off your next purchase!"
          },
          "sound": "custom_sound.caf",
          "content-available": 1
        }
      }
    }
  }
}
 
 */
