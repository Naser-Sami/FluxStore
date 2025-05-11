abstract class INotificationsService {
  Future<void> sendNotification({
    required String fcmToken,
    required String title,
    required String body,
    required Map<String, String> data,
  });
}
