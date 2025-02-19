import '../network/api/zinc_request_response.dart';

class BaseResponse {
  int? status;
  String? message;
  ZincAPIError? error;
  bool get hasError => error != null;

  BaseResponse();

  BaseResponse.error(this.error);

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse()
      ..status = int.parse(json['status'])
      ..message = json['message'];
  }
}
