

import 'package:network_module/data/network/error_handler.dart';

class Failure {
  int code; // 200 or 400
  String message; // error or success

  Failure(this.code, this.message);

  Map<String, dynamic> toJson() {
    return {
      "code": this.code,
      "message": this.message,
    };
  }
}

class DefaultFailure extends Failure {
  DefaultFailure() : super(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
}
