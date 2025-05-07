import 'dart:convert';
import 'dart:developer' show log;

import 'package:flutter/material.dart';

import '/core/_core.dart' show ApiClient, sl;
import 'web_socket_service.dart';
import 'websocket.dart';

// 44bf8f45a2d047a49a3f1ba098515266
class RealTimeStockWidget extends StatefulWidget {
  static const routeName = '/real-time-stock';
  static const name = 'Real Time Stock';

  @override
  RealTimeStockWidgetState createState() => RealTimeStockWidgetState();
}

class RealTimeStockWidgetState extends State<RealTimeStockWidget> {
  late WebSocketService _webSocketService;
  final Map<String, PriceUpdateEvent> _latestPrices = {};
  final apiClient = sl<ApiClient>();

  final List<String> _symbols = [
    "AAPL",
    "INFY",
    "TRP",
    "QQQ",
    "IXIC",
    "EUR/USD",
    "USD/JPY",
    "BTC/USD",
    "ETH/BTC",
    "RY",
    "RY:TSX",
    "GOOG",
    "MSFT",
    "TSLA",
    "AMZN",
    "META",
    "NFLX",
    "NVDA",
    "ADBE",
    "INTC",
    "BABA",
    "V",
    "MA",
  ];

  @override
  void initState() {
    super.initState();
    _webSocketService = WebSocketService(
      'wss://ws.twelvedata.com/v1/quotes/price?apikey=44bf8f45a2d047a49a3f1ba098515266',
    );
    _fetchInitialPrices();
    _subscribeToWebSocket();
    _listenToSocket();
  }

  void _subscribeToWebSocket() {
    final batched = <List<String>>[];

    for (var i = 0; i < _symbols.length; i += 12) {
      batched.add(
        _symbols.sublist(
          i,
          (i + 12 > _symbols.length) ? _symbols.length : i + 12,
        ),
      );
    }

    for (final batch in batched) {
      _webSocketService.sendMessage({
        "action": "subscribe",
        "params": {"symbols": batch.join(",")},
      });
    }
  }

  void _listenToSocket() {
    _webSocketService.stream.listen((raw) {
      final decoded = jsonDecode(raw);
      final event = decoded['event'];

      if (event == "price") {
        final priceEvent = PriceUpdateEvent.fromJson(decoded);
        log("📈 Live update: ${priceEvent.symbol} - ${priceEvent.price}");
        setState(() {
          _latestPrices[priceEvent.symbol] = priceEvent;
        });
      } else if (event == "subscribe-status") {
        log("✅ Subscription confirmed: ${decoded['success']}");
      }
    });
  }

  Future<void> _fetchInitialPrices() async {
    final batched = <List<String>>[];

    for (var i = 0; i < _symbols.length; i += 12) {
      batched.add(
        _symbols.sublist(
          i,
          (i + 12 > _symbols.length) ? _symbols.length : i + 12,
        ),
      );
    }

    for (final batch in batched) {
      final response = await apiClient.get(
        path: 'https://api.twelvedata.com/price',
        queryParameters: {
          'symbol': batch.join(','),
          'apikey': '44bf8f45a2d047a49a3f1ba098515266',
        },
      );

      setState(() {
        response.forEach((symbol, data) {
          _latestPrices[symbol] = PriceUpdateEvent(
            event: "initial",
            symbol: symbol,
            price: double.tryParse(data['price'] ?? '0') ?? 0,
            timestamp: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          );
        });
      });
    }
  }

  @override
  void dispose() {
    _webSocketService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sortedEntries =
        _latestPrices.entries.toList()..sort((a, b) => a.key.compareTo(b.key));

    return Scaffold(
      appBar: AppBar(title: const Text('📈 Live Stock Prices')),
      body:
          _latestPrices.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: sortedEntries.length,
                itemBuilder: (_, index) {
                  final e = sortedEntries[index].value;
                  return ListTile(
                    title: Text(e.symbol),
                    subtitle: Text('Price: \$${e.price.toStringAsFixed(2)}'),
                    trailing: Text(
                      '⏱ ${DateTime.fromMillisecondsSinceEpoch(e.timestamp * 1000).toLocal()}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  );
                },
              ),
    );
  }
}
