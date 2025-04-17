import '/core/_core.dart' show InternetStatus;

extension InternetStatusExtension on InternetStatus {
  bool get isConnected => this == InternetStatus.connected;
  bool get isDisconnected => this == InternetStatus.disconnected;
}
