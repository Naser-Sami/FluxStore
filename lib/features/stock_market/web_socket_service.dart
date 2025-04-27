import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  final String _url;
  late final WebSocketChannel _channel;

  WebSocketService(this._url) {
    _channel = WebSocketChannel.connect(Uri.parse(_url));
  }

  // Use cast<String>() since the stream emits String values
  Stream<String> get stream => _channel.stream.cast<String>();

  void sendMessage(Map<String, dynamic> message) {
    _channel.sink.add(jsonEncode(message));
  }

  void dispose() {
    _channel.sink.close();
  }
}
