import 'package:graphql_flutter/graphql_flutter.dart';

import 'graphql_config.dart';

class GraphQLService {
  final GraphQLClient _client = GraphQLConfig.getClient();

  Future<QueryResult> query({
    required String query,
    Map<String, dynamic>? variables,
    bool fetchFromNetwork = false,
  }) async {
    final options = QueryOptions(
      document: gql(query),
      variables: variables ?? {},
      fetchPolicy:
          fetchFromNetwork ? FetchPolicy.networkOnly : FetchPolicy.cacheFirst,
    );

    final result = await _client.query(options);
    _handleError(result);
    return result;
  }

  Future<QueryResult> mutate({
    required String mutation,
    Map<String, dynamic>? variables,
  }) async {
    final options = MutationOptions(
      document: gql(mutation),
      variables: variables ?? {},
    );

    final result = await _client.mutate(options);

    _handleError(result);
    return result;
  }

  Stream<QueryResult> subscribe({
    required String subscription,
    Map<String, dynamic>? variables,
  }) {
    final options = SubscriptionOptions(
      document: gql(subscription),
      variables: variables ?? {},
    );

    return _client.subscribe(options);
  }

  void _handleError(QueryResult result) {
    if (result.hasException) {
      // You can customize error handling here
      print('GraphQL Error: ${result.exception.toString()}');
      throw result.exception!;
    }
  }
}
