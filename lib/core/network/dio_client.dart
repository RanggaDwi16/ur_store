import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'interceptors.dart';

class DioClient {
  late final Dio _dio;

  DioClient()
      : _dio = Dio(
          BaseOptions(
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              responseType: ResponseType.json,
              sendTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10)),
        ) {
    if (kDebugMode) {
      _dio.interceptors.add(LoggerInterceptor());
    }
  }

  // HANDLE ERROR RESPONSE
  dynamic _handleError(DioException e) {
    switch (e.response?.statusCode) {
      case 400:
        throw DioException(
            requestOptions: e.requestOptions,
            response: e.response,
            message: "Bad Request: ${e.response?.data}",
            type: DioExceptionType.badResponse);
      case 401:
        throw DioException(
            requestOptions: e.requestOptions,
            response: e.response,
            message: "Unauthorized: Please check your credentials.",
            type: DioExceptionType.badResponse);
      case 403:
        throw DioException(
            requestOptions: e.requestOptions,
            response: e.response,
            message: "Forbidden: You don't have access.",
            type: DioExceptionType.badResponse);
      case 404:
        throw DioException(
            requestOptions: e.requestOptions,
            response: e.response,
            message: "Not Found: ${e.response?.data}",
            type: DioExceptionType.badResponse);
      case 500:
        throw DioException(
            requestOptions: e.requestOptions,
            response: e.response,
            message: "Internal Server Error: Try again later.",
            type: DioExceptionType.badResponse);
      case 503:
        throw DioException(
            requestOptions: e.requestOptions,
            response: e.response,
            message: "Service Unavailable: Server is down.",
            type: DioExceptionType.badResponse);
      default:
        throw DioException(
            requestOptions: e.requestOptions,
            response: e.response,
            message: "Unexpected Error: ${e.response?.statusMessage}",
            type: DioExceptionType.unknown);
    }
  }

  // GET METHOD
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // POST METHOD
  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // PUT METHOD
  Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // DELETE METHOD
  Future<Response> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
}
