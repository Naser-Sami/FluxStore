import 'dart:developer';

import 'package:dio/dio.dart';

class ApiErrorHandler {
  void handle(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        log('Connection timeout: ${error.message}');
        throw Exception('Connection timeout: ${error.message}');
      case DioExceptionType.receiveTimeout:
        log('Receive timeout: ${error.message}');
        throw Exception('Receive timeout: ${error.message}');
      case DioExceptionType.badResponse:
        log(
          'Bad response: ${error.response?.statusCode} ${error.response?.data}',
        );
        throw Exception(error.response?.data['message'] ?? 'Unexpected error');
      default:
        log('Unexpected error: ${error.message}');
        throw Exception('Unexpected error: ${error.message}');
    }
  }
}
