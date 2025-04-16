import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '_apis_service.dart';

class DioService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {
        'content-type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer ${ApiEndpoints.accessToken}',
      },
    ),
  );

  DioService() {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ),
    );
    dio.interceptors.add(AuthInterceptor(dio));
  }
}
