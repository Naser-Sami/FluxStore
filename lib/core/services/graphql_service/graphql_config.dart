import 'package:flutter/material.dart' show ValueNotifier;
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {
  static final String socketUrl = 'wss://api.escuelajs.co/graphql';
  static String? _accessToken;

  static void setAccessToken(String token) {
    _accessToken = token;
  }

  static final HttpLink httpLink = HttpLink('https://api.escuelajs.co/graphql');

  static Link getLink() {
    final AuthLink authLink = AuthLink(
      getToken:
          () async => _accessToken != null ? 'Bearer $_accessToken' : null,
    );

    final Link link = authLink.concat(httpLink);
    return link;
  }

  static ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(cache: GraphQLCache(store: InMemoryStore()), link: httpLink),
  );

  static GraphQLClient getClient() {
    return GraphQLClient(
      link: getLink(),
      cache: GraphQLCache(store: InMemoryStore()),
    );
  }

  static final WebSocketLink webSocketLink = WebSocketLink(
    socketUrl, // ✅ Use `wss://` for secure WebSocket
    config: SocketClientConfig(
      autoReconnect: true,
      inactivityTimeout: const Duration(seconds: 30),
      initialPayload: () async {
        return {
          'headers': {'Authorization': 'Bearer '},
        };
      },
    ),
  );

  static final Link combinedLink = Link.split(
    (request) => request.isSubscription,
    webSocketLink,
    httpLink,
  );
}
