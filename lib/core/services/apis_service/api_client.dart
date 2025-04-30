import 'dart:developer';

import 'package:dio/dio.dart';

import 'api_error_handler.dart';

class ApiClient {
  final Dio dio;
  final ApiErrorHandler errorHandler = ApiErrorHandler();

  ApiClient({required this.dio});

  CancelToken? cancelToken;

  void cancelOngoingRequests() {
    if (cancelToken != null && !cancelToken!.isCancelled) {
      cancelToken?.cancel('Request canceled.');
    }
    cancelToken = CancelToken();
  }

  Future<T?> request<T>({
    required String path,
    required String method,
    Map<String, dynamic>? queryParameters,
    Object? data,
    Map<String, dynamic>? headers,
    CancelToken? token,
    T Function(dynamic data)? parser,
    Options? options,
  }) async {
    try {
      final response = await dio.request(
        path,
        options: options ?? Options(method: method, headers: headers),
        queryParameters: queryParameters,
        data: data,
        cancelToken: token ?? cancelToken,
      );

      if (parser != null) {
        return parser(response.data);
      } else {
        return response.data as T;
      }
    } on DioException catch (e) {
      errorHandler.handle(e);
      return null;
    } catch (e) {
      log('Unhandled error: $e');
      throw Exception(e);
    }
  }

  Future<T?> get<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? token,
    T Function(dynamic data)? parser,
  }) async {
    return request(
      path: path,
      method: 'GET',
      queryParameters: queryParameters,
      headers: headers,
      token: token,
      parser: parser,
    );
  }

  Future<T?> post<T>({
    required String path,
    Object? data,
    Map<String, dynamic>? headers,
    CancelToken? token,
    T Function(dynamic data)? parser,
    Options? options,
  }) async {
    return request(
      path: path,
      method: 'POST',
      options: options,
      data: data,
      headers: headers,
      token: token,
      parser: parser,
    );
  }

  Future<T?> put<T>({
    required String path,
    Object? data,
    Map<String, dynamic>? headers,
    CancelToken? token,
    T Function(dynamic data)? parser,
  }) async {
    return request(
      path: path,
      method: 'PUT',
      data: data,
      headers: headers,
      token: token,
      parser: parser,
    );
  }

  Future<T?> delete<T>({
    required String path,
    Object? data,
    Map<String, dynamic>? headers,
    CancelToken? token,
    T Function(dynamic data)? parser,
  }) async {
    return request(
      path: path,
      method: 'DELETE',
      data: data,
      headers: headers,
      token: token,
      parser: parser,
    );
  }
}
