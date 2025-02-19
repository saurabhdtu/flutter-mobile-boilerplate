import 'package:network_module/data/responses/responses.dart';

class BeneficiaryListResponse extends BaseResponse {
  BeneficiaryListResponse.error(error) : super.error(error);

  BeneficiaryListResponse.fromJson(dynamic json) {
    if (json != null) {
      _beneficiaryList = [];
      for (var v in (json as List)) {
        _beneficiaryList?.add(BeneficiaryResponse.fromJson(v));
      }
    }
  }

  List<BeneficiaryResponse>? _beneficiaryList;

  List<BeneficiaryResponse> get beneficiaryList => _beneficiaryList ?? [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_beneficiaryList != null) {
      map['beneficiary_list'] =
          _beneficiaryList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class BeneficiaryResponse extends BaseResponse {
  BeneficiaryResponse.error(error) : super.error(error);

  BeneficiaryResponse.fromJson(dynamic json) {
    _beneficiaryId = json['beneficiary_id']?.toString();
    _beneficiaryFullName = json['beneficiary_full_name'];
    _beneficiaryShortName = json['beneficiary_short_name'];
    _beneficiaryType = json['beneficiary_type'];
    _studentDetails = json['student_details'] != null
        ? StudentDetails.fromJson(json['student_details'])
        : null;
    _bankDetails = json['bank_details'] != null
        ? BeneficiaryBankDetails.fromJson(json['bank_details'])
        : null;
  }

  BeneficiaryResponse(this._beneficiaryId, this._beneficiaryFullName,
      this._beneficiaryType, this._bankDetails);

  String? _beneficiaryId;
  String? _beneficiaryFullName;

  String? _beneficiaryType;
  String? _beneficiaryShortName;
  StudentDetails? _studentDetails;
  BeneficiaryBankDetails? _bankDetails;

  String get beneficiaryType => _beneficiaryType ?? "";

  String get beneficiaryId => _beneficiaryId ?? "";

  String get beneficiaryFullName => _beneficiaryFullName ?? "";

  String? get beneficiaryShortName =>
      _beneficiaryShortName ?? beneficiaryFullName;

  StudentDetails? get studentDetails => _studentDetails;

  BeneficiaryBankDetails? get bankDetails => _bankDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['beneficiary_id'] = _beneficiaryId;
    map['beneficiary_full_name'] = _beneficiaryFullName;
    map['beneficiary_short_name'] = _beneficiaryShortName;
    map['beneficiary_type'] = _beneficiaryType;
    if (_studentDetails != null) {
      map['student_details'] = _studentDetails?.toJson();
    }
    if (_bankDetails != null) {
      map['bank_details'] = _bankDetails?.toJson();
    }
    return map;
  }
}

class BeneficiaryBankDetails {
  BeneficiaryBankDetails.fromJson(dynamic json) {
    _id = json['id']?.toString();
    _accountName = json['account_name'];
    _accountNumber = json['account_number'];
    _routingNumber = json['routing_number'];
    _bankName = json['bank_name'];
    _ifscCode = json['ifsc_code'];
  }

  BeneficiaryBankDetails(this._id, this._accountNumber, this._bankName);

  String? _id;
  String? _accountName;
  String? _accountNumber;
  String? _routingNumber;
  String? _bankName;
  String? _ifscCode;

  String get id => _id ?? "";

  String get accountName => _accountName ?? "";

  String get accountNumber => _accountNumber ?? "";

  String? get routingNumber => _routingNumber;

  String get bankName => _bankName ?? "";

  String? get ifscCode => _ifscCode;

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

class StudentDetails {
  StudentDetails.fromJson(dynamic json) {
    _studentId = json['student_id']?.toString();
    _fullName = json['full_name'];
    _shortName = json['short_name'];
    _loanDocumentAvailable = json['loan_document_available'];
  }

  String? _studentId;
  String? _fullName;
  String? _shortName;
  bool? _loanDocumentAvailable;

  String get studentId => _studentId ?? "";

  String get fullName => _fullName ?? "";

  String get shortName => _shortName ?? "";

  bool get loanDocumentAvailable => _loanDocumentAvailable ?? false;

  set loanDocumentAvailable(bool value) {
    _loanDocumentAvailable = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['student_id'] = _studentId;
    map['full_name'] = _fullName;
    map['short_name'] = _shortName;
    map['loan_document_available'] = _loanDocumentAvailable;
    return map;
  }
}

class GroupedBeneficiaryListResponse extends BaseResponse {
  GroupedBeneficiaryListResponse.error(error) : super.error(error);

  GroupedBeneficiaryListResponse.fromJson(dynamic json) {
    if (json != null) {
      _beneficiaryList = [];
      for (var v in (json as List)) {
        _beneficiaryList?.add(GroupedBeneficiaryResponse.fromJson(v));
      }
    }
  }

  List<GroupedBeneficiaryResponse>? _beneficiaryList;

  List<GroupedBeneficiaryResponse> get beneficiaryList =>
      _beneficiaryList ?? [];
}

class GroupedBeneficiaryResponse extends BaseResponse {
  GroupedBeneficiaryResponse.error(error) : super.error(error);

  GroupedBeneficiaryResponse.fromJson(dynamic json) {
    if (json != null) {
      _beneficiaryType = json["beneficiary_type"];
      _beneficiaryList = [];
      for (var v in (json["beneficiary_list"] as List)) {
        _beneficiaryList?.add(BeneficiaryResponse.fromJson(v));
      }
    }
  }

  String? _beneficiaryType;

  String get beneficiaryType => _beneficiaryType ?? "";

  List<BeneficiaryResponse>? _beneficiaryList;

  List<BeneficiaryResponse> get beneficiaryList => _beneficiaryList ?? [];
}

class AddBeneficiaryResponse extends BaseResponse {
  AddBeneficiaryResponse.error(err) : super.error(err);
  String? _beneficiaryId;
  String? _beneficiaryBankId;

  AddBeneficiaryResponse.fromJson(dynamic json) {
    _beneficiaryId = json['beneficiary_id'];
    _beneficiaryBankId = json['beneficiary_bank_id'];
  }

  String? get beneficiaryId => _beneficiaryId;
  String? get beneficiaryBankId => _beneficiaryBankId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['beneficiary_id'] = _beneficiaryId;
    map['beneficiary_bank_id'] = _beneficiaryBankId;
    return map;
  }
}

///Receiver Reason Based Students List Response
class StudentListResponse extends BaseResponse {
  StudentListResponse.error(error) : super.error(error);

  StudentListResponse();

  StudentListResponse.fromJson(dynamic json) {
    if (json != null) {
      _receiverReasonBasedStudentList = [];
      for (var v in (json as List)) {
        _receiverReasonBasedStudentList?.add(Student.fromJson(v));
      }
    }
  }

  List<Student>? _receiverReasonBasedStudentList;

  List<Student> get studentList => _receiverReasonBasedStudentList ?? [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_receiverReasonBasedStudentList != null) {
      map['student_list'] =
          _receiverReasonBasedStudentList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Student extends BaseResponse {
  Student.error(error) : super.error(error);

  String? _id;
  String? _shortName;
  String? _fullName;
  bool? _verified;
  bool? _loanDocumentAvailable;
  String? _countryName;

  Student(
      {String? id,
        String? shortName,
        String? fullName,
        bool? verified,
        bool? loanDocumentAvailable,
        String? countryName}) {
    if (id != null) {
      this._id = id;
    }
    if (shortName != null) {
      this._shortName = shortName;
    }
    if (fullName != null) {
      this._fullName = fullName;
    }
    if (verified != null) {
      this._verified = verified;
    }
    if (loanDocumentAvailable != null) {
      this._loanDocumentAvailable = loanDocumentAvailable;
    }
    if (countryName != null) {
      this._countryName = countryName;
    }
  }

  String? get id => _id;

  set id(String? id) => _id = id;

  String? get shortName => _shortName;

  set shortName(String? shortName) => _shortName = shortName;

  String? get fullName => _fullName;

  set fullName(String? fullName) => _fullName = fullName;

  bool? get verified => _verified;

  set verified(bool? verified) => _verified = verified;

  bool? get loanDocumentAvailable => _loanDocumentAvailable;

  set loanDocumentAvailable(bool? loanDocumentAvailable) =>
      _loanDocumentAvailable = loanDocumentAvailable;

  String? get countryName => _countryName;

  set countryName(String? countryName) => _countryName = countryName;

  Student.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _shortName = json['short_name'];
    _fullName = json['full_name'];
    _verified = json['verified'];
    _loanDocumentAvailable = json['loan_document_available'];
    _countryName = json['country_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['short_name'] = this._shortName;
    data['full_name'] = this._fullName;
    data['verified'] = this._verified;
    data['loan_document_available'] = this._loanDocumentAvailable;
    data['country_name'] = this._countryName;
    return data;
  }
}

///end
///end
///Receiver Reason Response
class ReceiverReasonListResponse extends BaseResponse {
  ReceiverReasonListResponse.error(error) : super.error(error);

  ReceiverReasonListResponse();

  List<ReceiverReasonList>? _beneficiaryList;

  List<ReceiverReasonList>? get beneficiaryList => _beneficiaryList;

  ReceiverReasonListResponse.fromJson(dynamic json) {
    if (json != null) {
      _beneficiaryList = [];
      for (var v in (json as List)) {
        _beneficiaryList?.add(ReceiverReasonList.fromJson(v));
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._beneficiaryList != null) {
      data['beneficiary_list'] =
          this._beneficiaryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReceiverReasonList extends BaseResponse {
  ReceiverReasonList.error(error) : super.error(error);

  String? _beneficiaryTypeKey;
  String? _beneficiaryTypeValue;

  ReceiverReasonList(
      {String? beneficiaryTypeKey, String? beneficiaryTypeValue}) {
    if (beneficiaryTypeKey != null) {
      this._beneficiaryTypeKey = beneficiaryTypeKey;
    }
    if (beneficiaryTypeValue != null) {
      this._beneficiaryTypeValue = beneficiaryTypeValue;
    }
  }

  String? get beneficiaryTypeKey => _beneficiaryTypeKey;

  set beneficiaryTypeKey(String? beneficiaryTypeKey) =>
      _beneficiaryTypeKey = beneficiaryTypeKey;

  String? get beneficiaryTypeValue => _beneficiaryTypeValue;

  set beneficiaryTypeValue(String? beneficiaryTypeValue) =>
      _beneficiaryTypeValue = beneficiaryTypeValue;

  ReceiverReasonList.fromJson(Map<String, dynamic> json) {
    _beneficiaryTypeKey = json['beneficiary_type_key'];
    _beneficiaryTypeValue = json['beneficiary_type_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['beneficiary_type_key'] = this._beneficiaryTypeKey;
    data['beneficiary_type_value'] = this._beneficiaryTypeValue;
    return data;
  }
}

///end
///Add Student Response
class AddStudentResponse extends BaseResponse {
  AddStudentResponse.error(err) : super.error(err);

  String? _studentId;

  AddStudentResponse.fromJson(dynamic json) {
    _studentId = json['student_id'];
  }

  String? get studentId => _studentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['student_id'] = _studentId;
    return map;
  }
}

///end
///Create Student Response
class CreateStudentResponse extends BaseResponse {
  CreateStudentResponse.error(err) : super.error(err);

  String? _studentId;

  CreateStudentResponse.fromJson(dynamic json) {
    _studentId = json['student_id'];
  }

  String? get studentId => _studentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['student_id'] = _studentId;
    return map;
  }
}

///end
///Student Documents Response
class BeneficiaryDocumentResponse extends BaseResponse {
  BeneficiaryDocumentResponse.error(error) : super.error(error);

  String? _type;
  List<Document>? _documents;

  BeneficiaryDocumentResponse.fromJson(dynamic json) {
    _type = json['type'];
    if (json['documents'] != null) {
      _documents = [];
      json['documents'].forEach((v) {
        _documents?.add(Document.fromJson(v));
      });
    }
  }

  String? get type => _type;

  List<Document>? get documents => _documents;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    if (_documents != null) {
      map['documents'] = _documents?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

///end
class Document {
  Document.fromJson(dynamic json) {
    _name = json['name'];
    _documentType = json['document_type'];
    _required = json['required'];
  }

  String? _name;
  String? _documentType;
  bool? _required;

  String? get name => _name;

  String? get documentType => _documentType;

  bool? get required => _required;

  set required(bool? value) {
    _required = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['document_type'] = _documentType;
    map['required'] = _required;
    return map;
  }
}


///end