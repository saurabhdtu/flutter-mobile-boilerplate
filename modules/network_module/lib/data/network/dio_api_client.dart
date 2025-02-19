import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:network_module/data/network/api/api_client.dart';
import 'package:network_module/data/network/api/dio_error_listener.dart';
import 'package:network_module/data/network/api/zinc_request_response.dart';
import 'package:network_module/data/network/error_handler.dart';
import 'package:network_module/data/network/failure.dart';
import 'package:network_module/data/responses/responses.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:utility_module/app_prefs.dart';
import 'package:utility_module/extensions/string_extensions.dart';
import 'package:utility_module/logger/logger.dart';

class DioAPIClient extends ApiClient {
  static DioAPIClient? _instance;
  late Dio _dio;
  late DioErrorListener _dioErrorListener;
  final bool isDevApp;

  DioAPIClient._(String url, this.isDevApp, DioErrorListener dioErrorListener) {
    _dio = Dio();
    _dioErrorListener = dioErrorListener;
    _dio.options = BaseOptions(
        baseUrl: url,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30));
    _dio.interceptors.clear();
    _dio.interceptors..add(_DioInterceptor(AppPreferences.getInstance, _dio));
    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true));
    }
  }

  static DioAPIClient initialize(
          String url, bool isDevApp, DioErrorListener errorListener) =>
      _instance ??= DioAPIClient._(url, isDevApp, errorListener);

  static DioAPIClient get instance => _instance!;

  @override
  Future<ZincAPIResponse<T>> makeRequest<T extends BaseResponse>(
      ZincAPIRequest<T> request) async {
    _logApiRequest(request);
    try {
      final response = await _dio.request(
        request.url,
        data: request.formData ??
            (request.body != null ? jsonEncode(request.body) : null),
        queryParameters: request.queryParams,
        cancelToken: request.cancelToken,
        onReceiveProgress: request.progressTracker?.receiveProgress,
        onSendProgress: request.progressTracker?.sendProgress,
        options: Options(
          validateStatus: (status) => ([]
                ..addAll(_successStatus)
                ..addAll(_redirectionStatus))
              .contains(status),
          method: _getMethod(request.requestType),
          headers: request.headers, // Pass headers here
          extra: {
            'disableAuth':
                request.disableAuth, // Add disableAuth to options.extra
          },
        ),
      );
      _logApiResponse(response.data);
      return Future.value(ZincAPIResponse.success(
          request.mapper?.call(response.data) ?? response.data));
    } catch (ex, trace) {
      return Future.value(ZincAPIResponse.error(_error(ex, trace)));
    }
  }

  String _getMethod(RequestType requestType) {
    switch (requestType) {
      case RequestType.get:
        return 'GET';
      case RequestType.post:
        return 'POST';
      case RequestType.put:
        return 'PUT';
      case RequestType.delete:
        return 'DELETE';
      case RequestType.patch:
        return 'PATCH';
    }
  }

  ZincAPIError _error(dynamic ex, StackTrace trace) {
    debugPrintStack(stackTrace: trace);
    logMessage(ex.toString(), writeToFile: true);
    if (ex is DioException &&
        ex.response?.statusCode == ResponseCode.UNAUTHORISED) {
      _dioErrorListener.onUserUnauthorized();
    }
    final failure = ErrorHandler.handle(ex).failure;
    _logApiError(failure);
    return ZincAPIError(message: failure.message, statusCode: failure.code);
  }

  _logApiError(Failure error) {
    logMessage(jsonEncode(error.toJson()), writeToFile: isDevApp);
  }

  _logApiRequest(ZincAPIRequest request) {
    logMessage(jsonEncode(request.toJson()), writeToFile: isDevApp);
  }

  _logApiResponse(response) {
    logMessage(jsonEncode(response), writeToFile: isDevApp);
  }
}

class _DioInterceptor extends Interceptor {
  final AppPreferences _appPreferences;
  final Dio _dio;

  _DioInterceptor(this._appPreferences, this._dio);

  HttpMethod _getHttpMethod(String method) {
    switch (method.toLowerCase()) {
      case "get":
        return HttpMethod.Get;
      case "post":
        return HttpMethod.Post;
      case "put":
        return HttpMethod.Put;
      case "patch":
        return HttpMethod.Patch;
      case "delete":
        return HttpMethod.Delete;
      case "head":
        return HttpMethod.Head;
      case "options":
        return HttpMethod.Options;
      default:
        return HttpMethod.Trace;
    }
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String token = await _appPreferences.getString(PrefKeys.authToken);
    final metric = FirebasePerformance.instance.newHttpMetric(
        options.uri.toString().replaceAll(options.baseUrl, ""),
        _getHttpMethod(options.method));
    int requestPayloadSize = 0;
    if (options.data != null) {
      if (options.data is String) {
        requestPayloadSize = (options.data as String).length;
      } else if (options.data is Map || options.data is List) {
        requestPayloadSize = options.data.toString().length;
      }
    }
    metric.requestPayloadSize = requestPayloadSize;
    await metric.start();
    options.extra['http_metric'] = metric;
    final disableAuth = options.extra['disableAuth'] as bool? ?? false;
    if (!disableAuth) {
      if (!token.isEmptyOrNull()) {
        logMessage("Bearer $token");
        options.headers["Authorization"] = "Bearer $token";
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (_redirectionStatus.contains(response.statusCode)) {
      final String? newUrl = response.headers['location']?[0];
      if (!newUrl.isEmptyOrNull()) {
        logMessage('Redirected to: $newUrl');
        try {
          response = await _dio.request(newUrl!,
              data: response.requestOptions.data,
              queryParameters: response.requestOptions.queryParameters,
              options: Options(
                  headers: response.requestOptions.headers
                    ..addAll(response.headers.map),
                  method: response.requestOptions.method));
        } catch (e) {
          if (e is DioException)
            handler.reject(e);
          else
            handler
                .reject(DioException(requestOptions: response.requestOptions));
          // return Future.value(ZincAPIResponse.error(_error(ex, trace)));
        }
      }
    }
    final metric = response.requestOptions.extra['http_metric'] as HttpMetric?;
    if (metric != null) {
      metric.responsePayloadSize = response.data.toString().length;
      metric.httpResponseCode = response.statusCode;
      metric.responseContentType =
          response.headers.map['content-type']?.firstOrNull ??
              "application/json";
      await metric.stop();
    }
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Retrieve and stop the metric in case of error
    final metric = err.requestOptions.extra['metric'] as HttpMetric?;
    if (metric != null) {
      // Set the response code in case of error
      metric.httpResponseCode = err.response?.statusCode;

      // Stop the metric
      await metric.stop();
    }

    handler.next(err); // Continue with the error
  }
}

const _redirectionStatus = [
  HttpStatus.movedPermanently,
  HttpStatus.movedTemporarily,
  HttpStatus.temporaryRedirect
];
const _successStatus = [
  HttpStatus.ok,
  HttpStatus.created,
  HttpStatus.accepted,
  HttpStatus.resetContent,
];
