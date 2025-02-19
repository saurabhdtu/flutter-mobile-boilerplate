import 'package:network_module/data/network/api/zinc_request_response.dart';
import 'package:network_module/data/responses/responses.dart';

class CreatePaymentResponse extends BaseResponse {
  CreatePaymentResponse(
      {num? amountBeneficiaryReceives,
      num? amountPayerPays,
      Beneficiary? beneficiary,
      String? beneficiaryId,
      String? createdAt,
      num? feeAmount,
      String? feeCurrency,
      String? feePaidBy,
      Funding? funding,
      String? lastUpdatedAt,
      Payer? payer,
      num? paymentAmount,
      String? paymentCurrency,
      String? paymentDate,
      String? paymentId,
      String? paymentMethod,
      String? reason,
      String? reference,
      String? remarks,
      String? requestId,
      bool? selling,
      String? shortReferenceId,
      num? sourceAmount,
      String? sourceCurrency,
      String? status,
      String? swiftChargeOption,
      String? underlyingConversionId}) {
    _amountBeneficiaryReceives = amountBeneficiaryReceives;
    _amountPayerPays = amountPayerPays;
    _beneficiary = beneficiary;
    _beneficiaryId = beneficiaryId;
    _createdAt = createdAt;
    _feeAmount = feeAmount;
    _feeCurrency = feeCurrency;
    _feePaidBy = feePaidBy;
    _funding = funding;
    _lastUpdatedAt = lastUpdatedAt;
    _payer = payer;
    _paymentAmount = paymentAmount;
    _paymentCurrency = paymentCurrency;
    _paymentDate = paymentDate;
    _paymentId = paymentId;
    _paymentMethod = paymentMethod;
    _reason = reason;
    _reference = reference;
    _remarks = remarks;
    _requestId = requestId;
    _selling = selling;
    _shortReferenceId = shortReferenceId;
    _sourceAmount = sourceAmount;
    _sourceCurrency = sourceCurrency;
    _status = status;
    _swiftChargeOption = swiftChargeOption;
    _underlyingConversionId = underlyingConversionId;
  }

  CreatePaymentResponse.fromJson(dynamic json) {
    _amountBeneficiaryReceives = json['amount_beneficiary_receives'];
    _amountPayerPays = json['amount_payer_pays'];
    _beneficiary = json['beneficiary'] != null
        ? Beneficiary.fromJson(json['beneficiary'])
        : null;
    _beneficiaryId = json['beneficiary_id'];
    _createdAt = json['created_at'];
    _feeAmount = json['fee_amount'];
    _feeCurrency = json['fee_currency'];
    _feePaidBy = json['fee_paid_by'];
    _funding =
        json['funding'] != null ? Funding.fromJson(json['funding']) : null;
    _lastUpdatedAt = json['last_updated_at'];
    _payer = json['payer'] != null ? Payer.fromJson(json['payer']) : null;
    _paymentAmount = json['payment_amount'];
    _paymentCurrency = json['payment_currency'];
    _paymentDate = json['payment_date'];
    _paymentId = json['payment_id'];
    _paymentMethod = json['payment_method'];
    _reason = json['reason'];
    _reference = json['reference'];
    _remarks = json['remarks'];
    _requestId = json['request_id'];
    _selling = json['selling'];
    _shortReferenceId = json['short_reference_id'];
    _sourceAmount = json['source_amount'];
    _sourceCurrency = json['source_currency'];
    _status = json['status'];
    _swiftChargeOption = json['swift_charge_option'];
    _underlyingConversionId = json['underlying_conversion_id'];
  }

  num? _amountBeneficiaryReceives;
  num? _amountPayerPays;
  Beneficiary? _beneficiary;
  String? _beneficiaryId;
  String? _createdAt;
  num? _feeAmount;
  String? _feeCurrency;
  String? _feePaidBy;
  Funding? _funding;
  String? _lastUpdatedAt;
  Payer? _payer;
  num? _paymentAmount;
  String? _paymentCurrency;
  String? _paymentDate;
  String? _paymentId;
  String? _paymentMethod;
  String? _reason;
  String? _reference;
  String? _remarks;
  String? _requestId;
  bool? _selling;
  String? _shortReferenceId;
  num? _sourceAmount;
  String? _sourceCurrency;
  String? _status;
  String? _swiftChargeOption;
  String? _underlyingConversionId;

  num? get amountBeneficiaryReceives => _amountBeneficiaryReceives;

  num? get amountPayerPays => _amountPayerPays;

  Beneficiary? get beneficiary => _beneficiary;

  String? get beneficiaryId => _beneficiaryId;

  String? get createdAt => _createdAt;

  num? get feeAmount => _feeAmount;

  String? get feeCurrency => _feeCurrency;

  String? get feePaidBy => _feePaidBy;

  Funding? get funding => _funding;

  String? get lastUpdatedAt => _lastUpdatedAt;

  Payer? get payer => _payer;

  num? get paymentAmount => _paymentAmount;

  String? get paymentCurrency => _paymentCurrency;

  String? get paymentDate => _paymentDate;

  String? get paymentId => _paymentId;

  String? get paymentMethod => _paymentMethod;

  String? get reason => _reason;

  String? get reference => _reference;

  String? get remarks => _remarks;

  String? get requestId => _requestId;

  bool? get selling => _selling;

  String? get shortReferenceId => _shortReferenceId;

  num? get sourceAmount => _sourceAmount;

  String? get sourceCurrency => _sourceCurrency;

  String? get payoutStatus => _status;

  String? get swiftChargeOption => _swiftChargeOption;

  String? get underlyingConversionId => _underlyingConversionId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount_beneficiary_receives'] = _amountBeneficiaryReceives;
    map['amount_payer_pays'] = _amountPayerPays;
    if (_beneficiary != null) {
      map['beneficiary'] = _beneficiary?.toJson();
    }
    map['beneficiary_id'] = _beneficiaryId;
    map['created_at'] = _createdAt;
    map['fee_amount'] = _feeAmount;
    map['fee_currency'] = _feeCurrency;
    map['fee_paid_by'] = _feePaidBy;
    if (_funding != null) {
      map['funding'] = _funding?.toJson();
    }
    map['last_updated_at'] = _lastUpdatedAt;
    if (_payer != null) {
      map['payer'] = _payer?.toJson();
    }
    map['payment_amount'] = _paymentAmount;
    map['payment_currency'] = _paymentCurrency;
    map['payment_date'] = _paymentDate;
    map['payment_id'] = _paymentId;
    map['payment_method'] = _paymentMethod;
    map['reason'] = _reason;
    map['reference'] = _reference;
    map['remarks'] = _remarks;
    map['request_id'] = _requestId;
    map['selling'] = _selling;
    map['short_reference_id'] = _shortReferenceId;
    map['source_amount'] = _sourceAmount;
    map['source_currency'] = _sourceCurrency;
    map['status'] = _status;
    map['swift_charge_option'] = _swiftChargeOption;
    map['underlying_conversion_id'] = _underlyingConversionId;
    return map;
  }

  CreatePaymentResponse.error(ZincAPIError? error) : super.error(error);
}

class Payer {
  Payer({
    Address? address,
    String? dateOfBirth,
    String? entityType,
    String? firstName,
    String? lastName,
  }) {
    _address = address;
    _dateOfBirth = dateOfBirth;
    _entityType = entityType;
    _firstName = firstName;
    _lastName = lastName;
  }

  Payer.fromJson(dynamic json) {
    _address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    _dateOfBirth = json['date_of_birth'];
    _entityType = json['entity_type'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
  }

  Address? _address;
  String? _dateOfBirth;
  String? _entityType;
  String? _firstName;
  String? _lastName;

  Address? get address => _address;

  String? get dateOfBirth => _dateOfBirth;

  String? get entityType => _entityType;

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    map['date_of_birth'] = _dateOfBirth;
    map['entity_type'] = _entityType;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    return map;
  }
}

class Address {
  Address({
    String? city,
    String? countryCode,
    String? postcode,
    String? state,
    String? streetAddress,
  }) {
    _city = city;
    _countryCode = countryCode;
    _postcode = postcode;
    _state = state;
    _streetAddress = streetAddress;
  }

  Address.fromJson(dynamic json) {
    _city = json['city'];
    _countryCode = json['country_code'];
    _postcode = json['postcode'];
    _state = json['state'];
    _streetAddress = json['street_address'];
  }

  String? _city;
  String? _countryCode;
  String? _postcode;
  String? _state;
  String? _streetAddress;

  String? get city => _city;

  String? get countryCode => _countryCode;

  String? get postcode => _postcode;

  String? get state => _state;

  String? get streetAddress => _streetAddress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['city'] = _city;
    map['country_code'] = _countryCode;
    map['postcode'] = _postcode;
    map['state'] = _state;
    map['street_address'] = _streetAddress;
    return map;
  }
}

class Funding {
  Funding({
    String? status,
  }) {
    _status = status;
  }

  Funding.fromJson(dynamic json) {
    _status = json['status'];
  }

  String? _status;

  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    return map;
  }
}

class Beneficiary {
  Beneficiary({
    AdditionalInfo? additionalInfo,
    Address? address,
    BankDetails? bankDetails,
    String? dateOfBirth,
    String? entityType,
  }) {
    _additionalInfo = additionalInfo;
    _address = address;
    _bankDetails = bankDetails;
    _dateOfBirth = dateOfBirth;
    _entityType = entityType;
  }

  Beneficiary.fromJson(dynamic json) {
    _additionalInfo = json['additional_info'] != null
        ? AdditionalInfo.fromJson(json['additional_info'])
        : null;
    _address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    _bankDetails = json['bank_details'] != null
        ? BankDetails.fromJson(json['bank_details'])
        : null;
    _dateOfBirth = json['date_of_birth'];
    _entityType = json['entity_type'];
  }

  AdditionalInfo? _additionalInfo;
  Address? _address;
  BankDetails? _bankDetails;
  String? _dateOfBirth;
  String? _entityType;

  AdditionalInfo? get additionalInfo => _additionalInfo;

  Address? get address => _address;

  BankDetails? get bankDetails => _bankDetails;

  String? get dateOfBirth => _dateOfBirth;

  String? get entityType => _entityType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_additionalInfo != null) {
      map['additional_info'] = _additionalInfo?.toJson();
    }
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    if (_bankDetails != null) {
      map['bank_details'] = _bankDetails?.toJson();
    }
    map['date_of_birth'] = _dateOfBirth;
    map['entity_type'] = _entityType;
    return map;
  }
}

class BankDetails {
  BankDetails({
    String? accountCurrency,
    String? accountName,
    String? accountNumber,
    String? bankCountryCode,
    String? bankName,
    String? swiftCode,
  }) {
    _accountCurrency = accountCurrency;
    _accountName = accountName;
    _accountNumber = accountNumber;
    _bankCountryCode = bankCountryCode;
    _bankName = bankName;
    _swiftCode = swiftCode;
  }

  BankDetails.fromJson(dynamic json) {
    _accountCurrency = json['account_currency'];
    _accountName = json['account_name'];
    _accountNumber = json['account_number'];
    _bankCountryCode = json['bank_country_code'];
    _bankName = json['bank_name'];
    _swiftCode = json['swift_code'];
  }

  String? _accountCurrency;
  String? _accountName;
  String? _accountNumber;
  String? _bankCountryCode;
  String? _bankName;
  String? _swiftCode;

  String? get accountCurrency => _accountCurrency;

  String? get accountName => _accountName;

  String? get accountNumber => _accountNumber;

  String? get bankCountryCode => _bankCountryCode;

  String? get bankName => _bankName;

  String? get swiftCode => _swiftCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['account_currency'] = _accountCurrency;
    map['account_name'] = _accountName;
    map['account_number'] = _accountNumber;
    map['bank_country_code'] = _bankCountryCode;
    map['bank_name'] = _bankName;
    map['swift_code'] = _swiftCode;
    return map;
  }
}

class AdditionalInfo {
  AdditionalInfo({
    String? personalEmail,
  }) {
    _personalEmail = personalEmail;
  }

  AdditionalInfo.fromJson(dynamic json) {
    _personalEmail = json['personal_email'];
  }

  String? _personalEmail;

  String? get personalEmail => _personalEmail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['personal_email'] = _personalEmail;
    return map;
  }
}
