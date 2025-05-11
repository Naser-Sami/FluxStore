import 'dart:developer' show log;

import '/config/routes/_routes.dart';

void handleNotification({required Map<String, dynamic> data}) {
  try {
    // Data contains what we sent in the notification
    String? route = data['route'];
    if (route != null) {
      router.go(route);
    }
  } catch (e) {
    log('Error handling notification: $e');
  }
}
