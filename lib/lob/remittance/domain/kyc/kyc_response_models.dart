import 'package:hyperkyc_flutter/hyperkyc_flutter_constants.dart';
import 'package:hyperkyc_flutter/hyperkyc_result.dart';
import 'package:network_module/data/responses/responses.dart';

class KycInitResponse extends BaseResponse {
  KycInitResponse.error(err) : super.error(err);

  KycInitResponse.fromJson(dynamic json) {
    _data = json['data'] != null ? KycInitData.fromJson(json['data']) : null;
  }

  KycInitData? _data;

  KycInitData? get data => _data;
}

class KycInitData {
  KycInitData.fromJson(dynamic json) {
    _remitterId = json['remitter_id'];
    _workflowId = json['workflow_id'];
    _transactionId = json['transaction_id'];
  }

  String? _remitterId;
  String? _workflowId;
  String? _transactionId;

  String get remitterId => _remitterId ?? "";

  String get workflowId => _workflowId ?? "";

  String get transactionId => _transactionId ?? "";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remitter_id'] = _remitterId;
    map['workflow_id'] = _workflowId;
    map['transaction_id'] = _transactionId;
    return map;
  }
}

class KycStatusResponse extends BaseResponse {
  KycStatusResponse.error(err) : super.error(err);

  KycStatusResponse.fromJson(dynamic json) {
    _data = json['data'] != null ? KycData.fromJson(json['data']) : null;
  }

  KycData? _data;

  KycData? get data => _data;
}

class KycData {
  KycData.fromJson(dynamic json) {
    _remitterId = json['remitter_id'];
    _transactionId = json['transaction_id'];
    _workflowId = json['workflow_id'];
    _applicationStatus = _getKycStatus(json['application_status']);
    _status = json['status'] != null ? Status.fromJson(json['status']) : null;
  }

  String? _remitterId;
  String? _transactionId;
  String? _workflowId;
  HyperKycStatus? _applicationStatus;
  Status? _status;

  String get remitterId => _remitterId ?? "";

  String get workflowId => _workflowId ?? "";

  String get transactionId => _transactionId ?? "";

  HyperKycStatus get applicationStatus =>
      _applicationStatus ?? HyperKycStatus.error;

  Status? get status => _status;

  HyperKycStatus _getKycStatus(json) {
    if (json is String) {
      switch (json) {
        case HyperKycConstants.error:
          return HyperKycStatus.error;
        case HyperKycConstants.autoApproved:
          return HyperKycStatus.autoApproved;
        case HyperKycConstants.autoDeclined:
          return HyperKycStatus.autoDeclined;
        case HyperKycConstants.manuallyApproved:
          return HyperKycStatus.manuallyApproved;
        case HyperKycConstants.manuallyDeclined:
          return HyperKycStatus.manuallyDeclined;
        case HyperKycConstants.needsReview:
          return HyperKycStatus.needsReview;
        case HyperKycConstants.ongoing:
          return HyperKycStatus.ongoing;
        case HyperKycConstants.userCancelled:
          return HyperKycStatus.userCancelled;
      }
      return HyperKycStatus.ongoing;
    } else {
      return HyperKycStatus.error;
    }
  }
}

class Status {
  Status({
    bool? pan,
    bool? dob,
    bool? yob,
    AadhaarData? aadhaarData,
    PanData? panData,
    bool? name,
  }) {
    _pan = pan;
    _dob = dob;
    _yob = yob;
    _aadhaarData = aadhaarData;
    _panData = panData;
    _name = name;
  }

  Status.fromJson(dynamic json) {
    _pan = json['pan'];
    _dob = json['dob'];
    _yob = json['yob'];
    _aadhaarData = json['aadhaar_data'] != null
        ? AadhaarData.fromJson(json['aadhaar_data'])
        : null;
    _panData =
        json['pan_data'] != null ? PanData.fromJson(json['pan_data']) : null;
    _name = json['name'];
  }

  bool? _pan;
  bool? _dob;
  bool? _yob;
  AadhaarData? _aadhaarData;
  PanData? _panData;
  bool? _name;

  bool? get pan => _pan;

  bool? get dob => _dob;

  bool? get yob => _yob;

  AadhaarData? get aadhaarData => _aadhaarData;

  PanData? get panData => _panData;

  bool? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pan'] = _pan;
    map['dob'] = _dob;
    map['yob'] = _yob;
    if (_aadhaarData != null) {
      map['aadhaar_data'] = _aadhaarData?.toJson();
    }
    if (_panData != null) {
      map['pan_data'] = _panData?.toJson();
    }
    map['name'] = _name;
    return map;
  }
}

class PanData {
  PanData({
    String? pan,
    String? dob,
  }) {
    _pan = pan;
    _dob = dob;
  }

  PanData.fromJson(dynamic json) {
    _pan = json['pan'];
    _dob = json['dob'];
  }

  String? _pan;
  String? _dob;

  String? get pan => _pan;

  String? get dob => _dob;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pan'] = _pan;
    map['dob'] = _dob;
    return map;
  }
}

class AadhaarData {
  AadhaarData({
    String? dob,
    String? fullName,
  }) {
    _dob = dob;
    _fullName = fullName;
  }

  AadhaarData.fromJson(dynamic json) {
    _dob = json['dob'];
    _fullName = json['full_name'];
  }

  String? _dob;
  String? _fullName;

  String? get dob => _dob;

  String? get fullName => _fullName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dob'] = _dob;
    map['full_name'] = _fullName;
    return map;
  }
}

class KycPanVerificationResponse extends BaseResponse {
  KycPanVerificationResponse.error(err) : super.error(err);

  PanVerificationData? data;

  KycPanVerificationResponse({this.data});

  factory KycPanVerificationResponse.fromJson(dynamic json) {
    return KycPanVerificationResponse(
      data: json['data'] != null
          ? PanVerificationData.fromJson(json["data"])
          : null,
    );
  }
}

class PanVerificationData {
  bool? _isPanVerified;
  String? _remitterId;
  String? _userErrorMessage;

  PanVerificationData.fromJson(Map<String, dynamic> json) {
    _isPanVerified = json["is_pan_verified"];
    _remitterId = json["remitter_id"];
    _userErrorMessage = json["user_error_message"];
  }

  String get userErrorMessage => _userErrorMessage ?? "";

  String get remitterId => _remitterId ?? "";

  bool get isPanVerified => _isPanVerified == true;
}

class IfscVerificationResponse extends BaseResponse {
  IfscVerification? data;
  bool? _status;

  IfscVerificationResponse.error(err) : super.error(err);

  IfscVerificationResponse.fromJson(json) {
    _status = json['status'];
    data =
        json['data'] != null ? IfscVerification.fromJson(json['data']) : null;
  }

  bool? get statuses => _status;

  IfscVerification? get dataDetails => data;
}

class IfscVerification {
  String? _city;
  bool? _neft;
  String? _branch;
  String? _centre;
  String? _district;
  bool? _upi;
  String? _iso3166;
  bool? _rtgs;
  bool? _imps;
  String? _contact;
  String? _state;
  String? _bank;
  String? _bankcode;
  String? _ifsc;

  String? get city => _city;

  bool? get neft => _neft;

  String? get branch => _branch;

  String? get centre => _centre;

  String? get district => _district;

  bool? get upi => _upi;

  String? get iso3166 => _iso3166;

  bool? get rtgs => _rtgs;

  bool? get imps => _imps;

  String? get contact => _contact;

  String? get state => _state;

  String? get bank => _bank;

  String? get bankcode => _bankcode;

  String? get ifsc => _ifsc;

  IfscVerification.fromJson(Map<String, dynamic> json) {
    _city = json['CITY'];
    _neft = json['NEFT'];
    _branch = json['BRANCH'];
    _centre = json['CENTRE'];
    _district = json['DISTRICT'];
    _upi = json['UPI'];
    _iso3166 = json['ISO3166'];
    _rtgs = json['RTGS'];
    _imps = json['IMPS'];
    _contact = json['CONTACT'];
    _state = json['STATE'];
    _bank = json['BANK'];
    _bankcode = json['BANKCODE'];
    _ifsc = json['IFSC'];
  }
}

class BankVerificationResponse extends BaseResponse {
  BankVerification? data;

  BankVerificationResponse.error(err) : super.error(err);

  BankVerificationResponse.fromJson(json) {
    data =
        json['data'] != null ? BankVerification.fromJson(json['data']) : null;
  }

  BankVerification? get dataDetails => data;
}

class BankVerification {
  String? _remitterId;
  String? _remitterBankId;
  bool? _isBankVerified;

  String? get remitterId => _remitterId;

  String? get remitterBankId => _remitterBankId;

  bool? get isBankVerified => _isBankVerified;

  BankVerification.fromJson(Map<String, dynamic> json) {
    _remitterId = json['remitter_id'];
    _remitterBankId = json['remitter_bank_id'];
    _isBankVerified = json['is_bank_verified'];
  }
}

///Passport data
class KycPassportDataResponse extends BaseResponse {
  KycPassportDataResponse.error(err) : super.error(err);

  Data? data;

  KycPassportDataResponse({this.data});

  KycPassportDataResponse.fromJson(dynamic json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? transactionId;
  String? applicationStatus;
  StudentData? studentData;

  Data({this.transactionId, this.applicationStatus, this.studentData});

  Data.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    applicationStatus = json['application_status'];
    studentData = json['student_data'] != null
        ? new StudentData.fromJson(json['student_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transaction_id'] = this.transactionId;
    data['application_status'] = this.applicationStatus;
    if (this.studentData != null) {
      data['student_data'] = this.studentData!.toJson();
    }
    return data;
  }
}

class StudentData {
  PassportData? passportData;

  StudentData({this.passportData});

  StudentData.fromJson(Map<String, dynamic> json) {
    passportData = json['passport_data'] != null
        ? new PassportData.fromJson(json['passport_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.passportData != null) {
      data['passport_data'] = this.passportData!.toJson();
    }
    return data;
  }
}

class PassportData {
  String? firstName;
  String? lastName;
  String? fullName;
  String? dob;
  String? passportNumber;
  String? issueDate;
  String? expiryDate;
  String? imageUrlFront;
  String? addressLine1;
  String? addressLine2;
  String? pincode;
  String? city;
  String? state;
  String? imageUrlBack;

  PassportData(
      {this.firstName,
      this.lastName,
      this.fullName,
      this.dob,
      this.passportNumber,
      this.issueDate,
      this.expiryDate,
      this.imageUrlFront,
      this.addressLine1,
      this.addressLine2,
      this.pincode,
      this.city,
      this.state,
      this.imageUrlBack});

  PassportData.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    fullName = json['full_name'];
    dob = json['dob'];
    passportNumber = json['passport_number'];
    issueDate = json['issue_date'];
    expiryDate = json['expiry_date'];
    imageUrlFront = json['image_url_front'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    pincode = json['pincode'];
    city = json['city'];
    state = json['state'];
    imageUrlBack = json['image_url_back'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['full_name'] = this.fullName;
    data['dob'] = this.dob;
    data['passport_number'] = this.passportNumber;
    data['issue_date'] = this.issueDate;
    data['expiry_date'] = this.expiryDate;
    data['image_url_front'] = this.imageUrlFront;
    data['address_line1'] = this.addressLine1;
    data['address_line2'] = this.addressLine2;
    data['pincode'] = this.pincode;
    data['city'] = this.city;
    data['state'] = this.state;
    data['image_url_back'] = this.imageUrlBack;
    return data;
  }
}
