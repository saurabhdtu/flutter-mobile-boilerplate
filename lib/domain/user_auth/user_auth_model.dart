import 'package:network_module/data/responses/responses.dart';

class SendOTPResponse extends BaseResponse {
  String? _referenceId;
  bool? _userExists;

  SendOTPResponse.error(err) : super.error(err);

  SendOTPResponse.fromJson(dynamic json) {
    _referenceId = json['reference_id'];
    _userExists = json['customer_exists'];
  }

  bool get userExists => _userExists == true;

  String get referenceId => _referenceId ?? "";
}

class VerifyOTPResponse extends BaseResponse {
  String? accessToken;
  String? refreshToken;
  String? sessionState;

  VerifyOTPResponse.error(err) : super.error(err);

  VerifyOTPResponse.fromJson(dynamic json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    sessionState = json['session_state'];
  }
}

class HomeResponse extends BaseResponse {
  // 'kycStatus'
  String? kycStatus;

  HomeResponse(this.kycStatus) : super.error(null);
}


class LocationResponse extends BaseResponse {
  LocationResponse.error(error) : super.error(error);

  LocationResponse.fromJson(dynamic json) {
    _data = json['data'] != null ? LocationData.fromJson(json['data']) : null;
  }

  LocationData? _data;

  LocationData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class LocationData {
  LocationData.fromJson(dynamic json) {
    _zipCode = json['zip_code'];
    _city = json['city'];
    _state = json['state'];
    _country = json['country'];
  }

  String? _zipCode;
  String? _city;
  String? _state;
  String? _country;

  String? get zipCode => _zipCode;

  String? get city => _city;

  String? get state => _state;

  String? get country => _country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['zip_code'] = _zipCode;
    map['city'] = _city;
    map['state'] = _state;
    map['country'] = _country;
    return map;
  }
}