import 'dart:async';

import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';

import '/core/_core.dart'
    show Constants, SecureStorageService, navigatorKey, sl;
import '/features/_features.dart' show WelcomeScreen;
import '_apis_service.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final _storage = sl<SecureStorageService>();
  final List<Function()> _retryQueue = [];
  bool _isRefreshing = false;

  AuthInterceptor(this.dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.read(key: Constants.keyToken);
    ApiEndpoints.accessToken = token;

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 &&
        !_isAuthRequest(err.requestOptions.path) &&
        ApiEndpoints.accessToken == null) {
      final completer = Completer<Response>();

      _retryQueue.add(() async {
        try {
          final newToken = await _storage.read(key: Constants.keyToken);
          ApiEndpoints.accessToken = newToken;

          err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
          final response = await dio.fetch(err.requestOptions);
          completer.complete(response);
        } catch (e) {
          completer.completeError(e);
        }
      });

      if (!_isRefreshing) {
        _isRefreshing = true;
        final success = await sl<RefreshTokenHandler>().tryRefreshToken();
        _isRefreshing = false;

        if (!success) {
          await _storage.deleteAll();
          ApiEndpoints.accessToken = null;
          navigatorKey.currentContext?.go(WelcomeScreen.routeName);
          return handler.reject(err);
        }

        final queue = List<Function()>.from(_retryQueue);
        _retryQueue.clear();
        for (var retry in queue) {
          retry();
        }
      }

      return handler.resolve(await completer.future);
    }

    return handler.next(err);
  }

  bool _isAuthRequest(String path) {
    return path.contains(ApiEndpoints.login) ||
        path.contains(ApiEndpoints.signUp) ||
        path.contains(ApiEndpoints.forgotPassword) ||
        path.contains(ApiEndpoints.resetPassword) ||
        path.contains(ApiEndpoints.refresh);
  }
}
