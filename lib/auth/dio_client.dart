
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';



enum ApiErrorType { Network, Server, Unexpected }

class ApiException implements Exception {
  final String message;
  final ApiErrorType type;

  ApiException(this.message, this.type);

  @override
  String toString() => 'ApiException: $message (type: $type)';
}

class DioClient {
  static const String _baseUrl = "http://164.52.197.27:8082";
  final Dio _dio;

  DioClient._internal(this._dio);

  factory DioClient() {
    final dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        persistentConnection: true,
        connectTimeout: const Duration(hours: 2),
        receiveTimeout: const Duration(hours: 2),
        sendTimeout: const Duration(hours: 2),
      ),
    );

    final logger = Logger(printer: PrettyPrinter());
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          var connectivityResult = await Connectivity().checkConnectivity();
          if (connectivityResult == ConnectivityResult.none){
            logger.e('No internet connection');
            throw ApiException('No internet connection', ApiErrorType.Network);
          }
          handler
              .
          next
            (
              options
          );
        },
        onResponse: (response, handler) {
          if (response.statusCode! >= 400) {
            final error = response.data['error'] as String?;
            final message = error ?? 'Server error';
            throw ApiException(message, ApiErrorType.Server);
          }
          handler.next(response);
        },
        onError: (DioException e, handler) {
          String errorMessage;
          switch (e.type) {
            case DioExceptionType.connectionTimeout:
              errorMessage = 'Connection timed out';
              break;
            case DioExceptionType.receiveTimeout:
              errorMessage
              = 'Server did not respond in time';
              break;
            case DioExceptionType.sendTimeout:
              errorMessage = 'Send timeout in connection';
              break;
            case DioExceptionType.cancel:
              errorMessage = 'Request was cancelled';
              break;
            default:
              errorMessage = 'An unexpected error occurred: ${e.message}';
          }
          logger.e(errorMessage);
          throw ApiException(errorMessage, ApiErrorType.Unexpected);
        },
      ),
    );

    // Optional: Add a log interceptor for debugging purposes (remove in production)
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
      ));
    }

    return DioClient._internal(dio);
  }

  Dio get dio => _dio;
}

