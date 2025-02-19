import 'package:network_module/data/responses/responses.dart';

class RemitterListResponse extends BaseResponse {
  RemitterListResponse.error(error) : super.error(error);
  List<RemitterResponse>? _list;

  RemitterListResponse.fromJson(dynamic json) {
    _list = json != null
        ? (json as List).map((e) => RemitterResponse.fromJson(e)).toList()
        : null;
  }

  List<RemitterResponse> get list => _list ?? [];
}

class RemitterResponse extends BaseResponse {
  RemitterResponse.error(error) : super.error(error);

  RemitterResponse.fromJson(dynamic json) {
    _remitterId = json['remitter_id']?.toString();
    _shortName = json['short_name'];
    _fullName = json['full_name'];
    _accountType = json['account_type'];
    _remitterStatus = json['remitter_status'] != null
        ? RemitterStatus.fromJson(json['remitter_status'])
        : null;
    _bankDetails = json['bank_details'] != null
        ? RemitterBankDetails.fromJson(json['bank_details'])
        : null;
  }

  RemitterResponse(this._remitterId, this._fullName, this._bankDetails);

  String? _remitterId;
  String? _shortName;
  String? _fullName;
  String? _accountType;
  RemitterStatus? _remitterStatus;
  RemitterBankDetails? _bankDetails;

  String get remitterId => _remitterId ?? "";

  String? get shortName => _shortName;

  String get fullName => _fullName ?? "";

  String? get accountType => _accountType;

  RemitterStatus? get remitterStatus => _remitterStatus;

  RemitterBankDetails? get bankDetails => _bankDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remitter_id'] = _remitterId;
    map['short_name'] = _shortName;
    map['full_name'] = _fullName;
    map['account_type'] = _accountType;
    if (_remitterStatus != null) {
      map['remitter_status'] = _remitterStatus?.toJson();
    }
    if(_bankDetails != null) {
      map['bank_details'] = _bankDetails?.toJson();
    }
    return map;
  }
}

class RemitterStatus {
  RemitterStatus({
    bool? kyc,
    bool? pan,
    bool? bank,
  }) {
    _kyc = kyc;
    _pan = pan;
    _bank = bank;
  }

  RemitterStatus.fromJson(dynamic json) {
    _kyc = json['kyc'];
    _pan = json['pan'];
    _bank = json['bank'];
  }

  bool? _kyc;
  bool? _pan;
  bool? _bank;

  bool? get kyc => _kyc;

  bool? get pan => _pan;

  bool? get bank => _bank;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['kyc'] = _kyc;
    map['pan'] = _pan;
    map['bank'] = _bank;
    return map;
  }
}

class RemitterBankDetails {
  String? _id;
  String? _accountName;
  String? _accountNumber;
  String? _routingNumber;
  String? _bankName;
  String? _ifscCode;

  String? get id => _id;

  String get accountName => _accountName ?? "";

  String get accountNumber => _accountNumber ?? "";

  String? get routingNumber => _routingNumber;

  String get bankName => _bankName ?? "";

  String? get ifscCode => _ifscCode;

  RemitterBankDetails(this._id, this._accountNumber, this._bankName);

  RemitterBankDetails.fromJson(dynamic json) {
    _id = json['id']?.toString();
    _accountName = json['account_name'];
    _accountNumber = json['account_number'];
    _routingNumber = json['routing_number'];
    _bankName = json['bank_name'];
    _ifscCode = json['ifsc_code'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['account_name'] = _accountName;
    map['account_number'] = _accountNumber;
    map['routing_number'] = _routingNumber;
    map['bank_name'] = _bankName;
    map['ifsc_code'] = _ifscCode;
    return map;
  }
}
