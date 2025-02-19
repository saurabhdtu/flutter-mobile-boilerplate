import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:network_module/data/network/progress_tracker.dart';
import 'package:network_module/data/responses/responses.dart';

class ZincAPIRequest<T> {
  final RequestType requestType;
  final String _url;
  final String? host;
  final CancelToken? cancelToken;
  final RequestProgressTracker? progressTracker;
  final Map<String, dynamic>? queryParams;
  final Map<String, dynamic>? headers;
  final Map<dynamic, dynamic>? body;
  final FormData? formData;
  final T Function(dynamic)? mapper;
  final bool? disableAuth;
  final bool clearEmptyFields;

  ZincAPIRequest(
      {required this.requestType,
      required String url,
      this.host,
      this.queryParams,
      this.headers,
      this.cancelToken,
      this.clearEmptyFields = true,
      this.progressTracker,
      this.mapper,
      this.body,
      this.formData,
      this.disableAuth})
      : _url = url;

  factory ZincAPIRequest.copyFrom(ZincAPIRequest<T> request,
      {String? baseUrl, Map<String, dynamic>? headers}) {
    return ZincAPIRequest<T>(
      requestType: request.requestType,
      url: request._url,
      host: baseUrl,
      body: request.clearEmptyFields
          ? request.cleanJsonForNullOREmptyFields(request.body)
          : request.body,
      formData: request.formData,
      headers: (request.headers?..addAll(headers ?? {})) ?? headers,
      mapper: request.mapper,
      queryParams: request.queryParams,
      disableAuth: request.disableAuth,
      progressTracker: request.progressTracker,
    );
  }

  Map<dynamic, dynamic> cleanJsonForNullOREmptyFields(
      Map<dynamic, dynamic>? json) {
    final cleanedJson = <dynamic, dynamic>{};
    json?.forEach((key, value) {
      if (value is Map<dynamic, dynamic>) {
        final cleanedValue = cleanJsonForNullOREmptyFields(value);
        cleanedJson[key] = cleanedValue;
      } else if (value is List) {
        final cleanedList = value
            .map((item) => item is Map<dynamic, dynamic>
                ? cleanJsonForNullOREmptyFields(item)
                : item)
            .where((item) => item != "")
            .toList();
        cleanedJson[key] = cleanedList;
      } else if (value != "") {
        cleanedJson[key] = value;
      }
    });
    return cleanedJson;
  }

  String get url => host == null ? _url : "$host$_url";

  String generateCurlCommand() {
    StringBuffer curlCommand = StringBuffer();

    curlCommand.write('curl -X ${_getRequestTypeString(requestType)} "$url');

    if (queryParams != null) {
      curlCommand.write('?${_mapToString(queryParams!)}"');
    } else {
      curlCommand.write('"');
    }

    if (headers != null) {
      headers!.forEach((key, value) {
        curlCommand.writeln(' \\\n-H "$key: $value"');
      });
    }

    if (body != null) {
      curlCommand.writeln(' \\\n-d \'${json.encode(body)}\'');
    }

    return curlCommand.toString();
  }

  String _getRequestTypeString(RequestType requestType) {
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

  String _mapToString(Map<String, dynamic> map) {
    return map.entries.map((entry) => '${entry.key}=${entry.value}').join('&');
  }

  Map<String, dynamic> toJson() {
    return {
      "requestType": this.requestType.toString(),
      "_url": this._url,
      "host": this.host,
      "queryParams": this.queryParams,
      "headers": this.headers,
      "body": jsonEncode(this.body)
    };
  }
}

enum RequestType { get, post, put, delete, patch }

class ZincAPIResponse<T extends BaseResponse> {
  T? body;

  ZincAPIError? error;

  ZincAPIResponse.success(this.body);

  bool get hasError => error != null;

  ZincAPIResponse.error(this.error);
}

class ZincAPIError {
  int? statusCode;
  String? message;

  ZincAPIError({this.statusCode, this.message});
}
