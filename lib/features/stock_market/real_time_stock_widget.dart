import 'dart:convert';

import 'package:flutter/material.dart';

import 'web_socket_service.dart';
import 'websocket.dart';

class RealTimeStockWidget extends StatefulWidget {
  static const routeName = '/real-time-stock';
  static const name = 'Real Time Stock';
  @override
  RealTimeStockWidgetState createState() => RealTimeStockWidgetState();
}

class RealTimeStockWidgetState extends State<RealTimeStockWidget> {
  late WebSocketService _webSocketService;
  final Map<String, PriceUpdateEvent> _latestPrices = {};

  @override
  void initState() {
    super.initState();
    _webSocketService = WebSocketService(
      'wss://ws.twelvedata.com/v1/quotes/price?apikey=44bf8f45a2d047a49a3f1ba098515266',
    );

    _webSocketService.sendMessage({
      "action": "subscribe",
      "params": {
        "symbols":
            "AAPL,INFY,TRP,QQQ,IXIC,EUR/USD,USD/JPY,BTC/USD,ETH/BTC,RY,RY:TSX",
      },
    });

    _webSocketService.stream.listen((raw) {
      final decoded = jsonDecode(raw);
      final event = decoded['event'];

      if (event == "price") {
        final priceEvent = PriceUpdateEvent.fromJson(decoded);
        setState(() {
          _latestPrices[priceEvent.symbol] = priceEvent;
        });
      } else if (event == "subscribe-status") {
        final success = decoded['success'];
        print("✅ Subscription confirmed $success");
      }
    });
  }

  @override
  void dispose() {
    _webSocketService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('📈 Live Prices')),
      body:
          _latestPrices.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                children:
                    _latestPrices.entries.map((entry) {
                      final e = entry.value;
                      return ListTile(
                        title: Text(e.symbol),
                        subtitle: Text('Price: ${e.price}'),
                        trailing: Text(
                          '⏱ ${DateTime.fromMillisecondsSinceEpoch(e.timestamp * 1000)}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      );
                    }).toList(),
              ),
    );
  }
}
