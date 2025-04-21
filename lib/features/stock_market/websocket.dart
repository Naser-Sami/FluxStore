abstract class WebSocketEvent {}

class SubscribeStatusEvent extends WebSocketEvent {
  final String? event;
  final String? status;
  final List<Success> success;
  final List<Fail> fails;

  SubscribeStatusEvent({
    this.event,
    this.status,
    required this.success,
    required this.fails,
  });

  factory SubscribeStatusEvent.fromJson(Map<String, dynamic> json) {
    return SubscribeStatusEvent(
      event: json["event"],
      status: json["status"],
      success: List<Success>.from(
        json["success"].map((x) => Success.fromJson(x)),
      ),
      fails: List<Fail>.from(json["fails"].map((x) => Fail.fromJson(x))),
    );
  }
}

class PriceUpdateEvent extends WebSocketEvent {
  final String event;
  final String symbol;
  final double price;
  final int timestamp;
  final String? currency;
  final String? currencyBase;
  final String? currencyQuote;
  final String? type;
  final String? exchange;

  PriceUpdateEvent({
    required this.event,
    required this.symbol,
    required this.price,
    required this.timestamp,
    this.currency,
    this.currencyBase,
    this.currencyQuote,
    this.type,
    this.exchange,
  });

  factory PriceUpdateEvent.fromJson(Map<String, dynamic> json) {
    return PriceUpdateEvent(
      event: json["event"],
      symbol: json["symbol"],
      price: json["price"].toDouble(),
      timestamp: json["timestamp"],
      currency: json["currency"],
      currencyBase: json["currency_base"],
      currencyQuote: json["currency_quote"],
      type: json["type"],
      exchange: json["exchange"],
    );
  }
}

class Success {
  final String symbol;
  final String type;

  Success({required this.symbol, required this.type});

  factory Success.fromJson(Map<String, dynamic> json) =>
      Success(symbol: json["symbol"], type: json["type"]);
}

class Fail {
  final String symbol;

  Fail({required this.symbol});

  factory Fail.fromJson(Map<String, dynamic> json) =>
      Fail(symbol: json["symbol"]);
}
