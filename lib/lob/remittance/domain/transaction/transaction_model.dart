import 'dart:ui';

import 'package:network_module/data/responses/responses.dart';
import 'package:design_module/old_design/resources/color_manager.dart';
import 'package:zinc/constants/strings.dart';
import 'package:zinc/lob/remittance/domain/beneficiary/beneficiary_models.dart';
import 'package:zinc/lob/remittance/domain/remitter/remitter_model.dart';


class SOFResponse extends BaseResponse {
  SOFResponse.error(err) : super.error(err);

  String? statusText;

  SOFResponse({this.statusText});

  SOFResponse.fromJson(dynamic json) {
    statusText = json['status'];
  }
}

class TransactionListResponse extends BaseResponse {
  TransactionListResponse.error(err) : super.error(err);
  List<TransactionResponse>? _list;

  TransactionListResponse.fromJson(json) {
    _list = json != null && json is List
        ? json.map((e) => TransactionResponse.fromJson(e)).toList()
        : [];
  }

  List<TransactionResponse> get list => _list ?? [];
}

class TransactionResponse extends BaseResponse {
  TransactionResponse.error(err) : super.error(err);

  TransactionResponse.fromJson(dynamic json) {
    _txnId = json['txn_id']?.toString();
    _status = json['status'];
    _amount = json['amount'];
    _expiry = json['expiry'];
    _inputCurrency = json['input_currency'];
    _currencySymbol = json['currency_symbol'];
    _date = json['date'];
    _purpose = json['purpose'];
    _additionalDetails = json['additional_details'] != null
        ? AdditionalDetails.fromJson(json['additional_details'])
        : null;
    _beneficiary = json['beneficiary'] != null
        ? Beneficiary.fromJson(json['beneficiary'])
        : null;
    _remitter =
        json['remitter'] != null ? Remitter.fromJson(json['remitter']) : null;
  }

  String? _txnId;
  String? _status;
  String? _expiry;
  num? _amount;
  String? _inputCurrency;
  String? _fromCurrency;
  String? _currencySymbol;
  String? _fromCurrencySymbol;
  String? _date;
  String? _purpose;
  Beneficiary? _beneficiary;
  Remitter? _remitter;
  AdditionalDetails? _additionalDetails;

  String get txnId => _txnId ?? "";

  TransactionStatus txnStatus() {
    switch (_status?.toLowerCase().trim()) {
      case "quote_initiated":
        return TransactionStatus.QUOTE_INITIATED;
      case "doc_received":
        return TransactionStatus.DOC_RECEIVED;
      case "waiting_for_fund":
        return TransactionStatus.WAITING_FOR_FUND;
      case "fund_received":
        return TransactionStatus.FUND_RECEIVED;
      case "initiated":
        return TransactionStatus.INITIATED;
      case "hold":
        return TransactionStatus.HOLD;
      case "processed":
        return TransactionStatus.PROCESSED;
      case "completed":
        return TransactionStatus.COMPLETED;
      case "rejected":
        return TransactionStatus.REJECTED;
      case "refunded":
        return TransactionStatus.REFUNDED;
      case "failed":
        return TransactionStatus.FAILED;
      default:
        return TransactionStatus.UNKNOWN;
    }
  }

  num get amount => _amount ?? 0;

  String? get toCurrency => _inputCurrency;

  String get fromCurrency => _fromCurrency ?? "INR";

  String? get expiry => _expiry;

  String get currencySymbol => _currencySymbol ?? "\$";

  String get fromCurrencySymbol =>
      _fromCurrencySymbol ?? AppStrings.rupeeSymbol;

  AdditionalDetails? get additionalDetails => _additionalDetails;

  String? get date => _date;

  String get purpose => _purpose ?? "";

  Beneficiary? get beneficiary => _beneficiary;

  Remitter? get remitter => _remitter;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['txn_id'] = _txnId;
    map['status'] = _status;
    map['amount'] = _amount;
    map['input_currency'] = _inputCurrency;
    map['date'] = _date;
    map['purpose'] = _purpose;
    if (_beneficiary != null) {
      map['beneficiary'] = _beneficiary?.toJson();
    }
    if (_remitter != null) {
      map['remitter'] = _remitter?.toJson();
    }
    return map;
  }
}

class AdditionalDetails {
  AdditionalDetails.fromJson(dynamic json) {
    _transactionId = json['transaction_id']?.toString();
    _amount = json['amount'];
    _exType = json['ex_type'];
    _fromCurrency = json['from_currency'];
    _fromCurrencySymbol = json['from_currency_symbol'];
    _toCurrency = json['to_currency'];
    _toCurrencySymbol = json['to_currency_symbol'];
    _exRate = json['ex_rate'];
    _fees = json['fees'];
    _otherCharges = json['other_charges'];
    _expiry = json['expiry'];
    _tcsAmt = json['tcs_amt'];
    _gstAmt = json['gst_amt'];
    _totalBankCharges = json['total_bank_charges'];
    _totalAdditionalAmount = json['total_additional_amount'];
    _finalFromAmount = json['final_from_amount'];
    _handleCharge = json['handle_charge'];
    _senderCurrencySymbol = json['sender_currency_symbol'];
  }

  String? _transactionId;
  num? _amount;
  String? _exType;
  String? _fromCurrency;
  String? _fromCurrencySymbol;
  String? _toCurrency;
  String? _toCurrencySymbol;
  String? _senderCurrencySymbol;
  num? _exRate;
  num? _fees;
  num? _otherCharges;
  String? _expiry;
  num? _tcsAmt;
  num? _gstAmt;
  num? _totalBankCharges;
  num? _totalAdditionalAmount;
  num? _finalFromAmount;
  num? _handleCharge;

  String? get transactionId => _transactionId;

  num? get amount => _amount;

  String? get exType => _exType;

  String? get fromCurrency => _fromCurrency;

  String? get fromCurrencySymbol => _fromCurrencySymbol;

  String get senderCurrencySymbol =>
      _senderCurrencySymbol ?? AppStrings.rupeeSymbol;

  num? get exRate => _exRate;

  String? get exRateTruncated => _exRate?.toStringAsFixed(2) ?? "";

  num? get fees => _fees;

  num? get otherCharges => _otherCharges;

  String? get expiry => _expiry;

  num? get tcsAmt => _tcsAmt;

  num? get gstAmt => _gstAmt;

  num? get totalBankCharges => _totalBankCharges;

  num? get totalAdditionalAmount => _totalAdditionalAmount;

  num? get finalFromAmount => _finalFromAmount;

  num? get handleCharge => _handleCharge;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['transaction_id'] = _transactionId;
    map['amount'] = _amount;
    map['ex_type'] = _exType;
    map['from_currency'] = _fromCurrency;
    map['from_currency_symbol'] = _fromCurrencySymbol;
    map['to_currency'] = _toCurrency;
    map['to_currency_symbol'] = _toCurrencySymbol;
    map['ex_rate'] = _exRate;
    map['fees'] = _fees;
    map['other_charges'] = _otherCharges;
    map['expiry'] = _expiry;
    map['tcs_amt'] = _tcsAmt;
    map['gst_amt'] = _gstAmt;
    map['total_bank_charges'] = _totalBankCharges;
    map['total_additional_amount'] = _totalAdditionalAmount;
    map['final_from_amount'] = _finalFromAmount;
    map['handle_charge'] = _handleCharge;
    return map;
  }

  String? get toCurrency => _toCurrency;

  String? get toCurrencySymbol => _toCurrencySymbol;
}

class Remitter {
  Remitter.fromJson(dynamic json) {
    _id = json['id']?.toString();
    _type = json['type'];
    _name = json['name'];
    _bankDetails = json['bank_details'] != null
        ? BankDetails.fromJson(json['bank_details'])
        : null;
  }

  RemitterResponse mapToRemitterResponse() {
    return RemitterResponse(
        _id,
        _name,
        RemitterBankDetails(_bankDetails?.id, _bankDetails?.accountNumber,
            _bankDetails?.bankName));
  }

  String? _id;
  dynamic _type;
  String? _name;
  BankDetails? _bankDetails;

  String? get id => _id;

  dynamic get type => _type;

  String get name => _name ?? "";

  BankDetails? get bankDetails => _bankDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['name'] = _name;
    if (_bankDetails != null) {
      map['bank_details'] = _bankDetails?.toJson();
    }
    return map;
  }
}

class BankDetails {
  BankDetails.fromJson(dynamic json) {
    _id = json['id'];
    _accountName = json['account_name'];
    _accountNumber = json['account_number'];
    _accountType = json['account_type'];
    _bankName = json['bank_name'];
  }

  String? _id;
  String? _accountName;
  String? _accountNumber;
  String? _accountType;
  String? _bankName;

  String? get id => _id;

  String? get accountName => _accountName;

  String? get accountNumber => _accountNumber;

  String? get accountType => _accountType;

  String? get bankName => _bankName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['account_name'] = _accountName;
    map['account_number'] = _accountNumber;
    map['account_type'] = _accountType;
    return map;
  }
}

class Beneficiary {
  Beneficiary.fromJson(dynamic json) {
    _id = json['id']?.toString();
    _type = json['type'];
    _name = json['name'];
    _bankDetails = json['bank_details'] != null
        ? BankDetails.fromJson(json['bank_details'])
        : null;
  }

  BeneficiaryResponse mapToBeneficiaryResponse() {
    return BeneficiaryResponse(
        _id,
        _name,
        _type,
        BeneficiaryBankDetails(_bankDetails?.id, _bankDetails?.accountNumber,
            _bankDetails?.bankName));
  }

  String? _id;
  String? _type;
  String? _name;
  BankDetails? _bankDetails;

  String? get id => _id ?? "";

  String? get type => _type;

  String get name => _name ?? "";

  BankDetails? get bankDetails => _bankDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['name'] = _name;
    if (_bankDetails != null) {
      map['bank_details'] = _bankDetails?.toJson();
    }
    return map;
  }
}

enum TransactionStatus {
  DOC_RECEIVED,
  WAITING_FOR_FUND,
  QUOTE_INITIATED,
  COMPLETED,
  FUND_RECEIVED,
  INITIATED,
  HOLD,
  REJECTED,
  REFUNDED,
  PROCESSED,
  FAILED,
  UNKNOWN
}

extension TransactionStatusComponent on TransactionStatus {
  String status() {
    switch (this) {
      case TransactionStatus.DOC_RECEIVED:
        return AppStrings.txnInProcess;
      case TransactionStatus.QUOTE_INITIATED:
        return AppStrings.txnInProcess;
      case TransactionStatus.WAITING_FOR_FUND:
        return AppStrings.txnInProcess;
      case TransactionStatus.FUND_RECEIVED:
        return AppStrings.txnFundReceived;
      case TransactionStatus.PROCESSED:
        return AppStrings.txnInProcess;
      case TransactionStatus.INITIATED:
        return AppStrings.txnInProcess;
      case TransactionStatus.HOLD:
        return AppStrings.txnOnHold;
      case TransactionStatus.COMPLETED:
        return AppStrings.txnSuccess;
      case TransactionStatus.REJECTED:
        return AppStrings.txnRejected;
      case TransactionStatus.REFUNDED:
        return AppStrings.txnRefund;
      case TransactionStatus.FAILED:
        return AppStrings.txnFailed;
      case TransactionStatus.UNKNOWN:
        return AppStrings.txnInProcess;
    }
  }

  Color statusColor() {
    switch (this) {
      case TransactionStatus.DOC_RECEIVED:
        return ColorManager.colorB1980C;
      case TransactionStatus.QUOTE_INITIATED:
        return ColorManager.colorB1980C;
      case TransactionStatus.WAITING_FOR_FUND:
        return ColorManager.colorB1980C;
      case TransactionStatus.FUND_RECEIVED:
        return ColorManager.colorB1980C;
      case TransactionStatus.INITIATED:
        return ColorManager.colorB1980C;
      case TransactionStatus.PROCESSED:
        return ColorManager.colorB1980C;
      case TransactionStatus.COMPLETED:
        return ColorManager.color09B447;
      case TransactionStatus.HOLD:
        return ColorManager.colorB2411F;
      case TransactionStatus.REJECTED:
        return ColorManager.colorB2411F;
      case TransactionStatus.REFUNDED:
        return ColorManager.color09B447;
      case TransactionStatus.FAILED:
        return ColorManager.colorB2411F;
      case TransactionStatus.UNKNOWN:
        return ColorManager.color09B447;
    }
  }

  String statusIcon() {
    switch (this) {
      case TransactionStatus.DOC_RECEIVED:
      case TransactionStatus.QUOTE_INITIATED:
      case TransactionStatus.FUND_RECEIVED:
      case TransactionStatus.INITIATED:
      case TransactionStatus.WAITING_FOR_FUND:
        return "ic_processing.svg";
      case TransactionStatus.COMPLETED:
        return "ic_sender.svg";
      case TransactionStatus.HOLD:
        return "ic_alert.svg";
      case TransactionStatus.REJECTED:
        return "ic_failed.svg";
      case TransactionStatus.REFUNDED:
        return "ic_retry.svg";
      case TransactionStatus.PROCESSED:
        return "ic_sender.svg";
      case TransactionStatus.FAILED:
        return "ic_failed.svg";
      case TransactionStatus.UNKNOWN:
        return "ic_processing.svg";
    }
  }

  String detailStatusIcon() {
    switch (this) {
      case TransactionStatus.DOC_RECEIVED:
      case TransactionStatus.WAITING_FOR_FUND:
      case TransactionStatus.QUOTE_INITIATED:
      case TransactionStatus.FUND_RECEIVED:
      case TransactionStatus.INITIATED:
        return "ic_transaction_process.svg";
      case TransactionStatus.COMPLETED:
        return "ic_transaction_success.svg";
      case TransactionStatus.HOLD:
        return "ic_transaction_error.svg";
      case TransactionStatus.REJECTED:
        return "ic_transaction_failed.svg";
      case TransactionStatus.REFUNDED:
        return "ic_transaction_refunded.svg";
      case TransactionStatus.PROCESSED:
        return "ic_transaction_success.svg";
      case TransactionStatus.FAILED:
        return "ic_transaction_failed.svg";
      case TransactionStatus.UNKNOWN:
        return "ic_transaction_process.svg";
    }
  }

  Color statusIconColor() {
    switch (this) {
      case TransactionStatus.DOC_RECEIVED:
        return ColorManager.colorB1980C;
      case TransactionStatus.WAITING_FOR_FUND:
        return ColorManager.colorB1980C;
      case TransactionStatus.QUOTE_INITIATED:
        return ColorManager.colorB1980C;
      case TransactionStatus.COMPLETED:
        return ColorManager.color1F1F1F;
      case TransactionStatus.FUND_RECEIVED:
        return ColorManager.colorB1980C;
      case TransactionStatus.INITIATED:
        return ColorManager.colorB1980C;
      case TransactionStatus.HOLD:
        return ColorManager.colorB2411F;
      case TransactionStatus.REJECTED:
        return ColorManager.colorB2411F;
      case TransactionStatus.REFUNDED:
        return ColorManager.color173D4F;
      case TransactionStatus.PROCESSED:
        return ColorManager.color1F1F1F;
      case TransactionStatus.FAILED:
        return ColorManager.colorB2411F;
      case TransactionStatus.UNKNOWN:
        return ColorManager.color173D4F;
    }
  }

  Color statusIconBGColor() {
    switch (this) {
      case TransactionStatus.DOC_RECEIVED:
        return ColorManager.colorFCF5CF;
      case TransactionStatus.WAITING_FOR_FUND:
        return ColorManager.colorFCF5CF;
      case TransactionStatus.QUOTE_INITIATED:
        return ColorManager.colorFCF5CF;
      case TransactionStatus.COMPLETED:
        return ColorManager.colorE5F4FA;
      case TransactionStatus.FUND_RECEIVED:
        return ColorManager.colorFCF5CF;
      case TransactionStatus.INITIATED:
        return ColorManager.colorFCF5CF;
      case TransactionStatus.HOLD:
        return ColorManager.colorF8DFD8;
      case TransactionStatus.REJECTED:
        return ColorManager.colorF8DFD8;
      case TransactionStatus.REFUNDED:
        return ColorManager.colorE5F4FA;
      case TransactionStatus.PROCESSED:
        return ColorManager.colorE5F4FA;
      case TransactionStatus.FAILED:
        return ColorManager.colorF8DFD8;
      case TransactionStatus.UNKNOWN:
        return ColorManager.colorFCF5CF;
    }
  }
}

///** initiate response
class InitTransactionResponse extends BaseResponse {
  InitTransactionResponse.error(err) : super.error(err);
  String? txnId;

  InitTransactionResponse.fromJson(dynamic json) {
    txnId = json['txn_id'];
  }
}

enum SourceOfFunds { self, loan }

extension SourceOfFundsDesc on SourceOfFunds {
  String getFundName() {
    switch (this) {
      case SourceOfFunds.loan:
        return 'Education Loan';
      case SourceOfFunds.self:
        return 'Self funded';
    }
  }

  String getEventButtonName() {
    switch (this) {
      case SourceOfFunds.loan:
        return 'edu_loan';
      case SourceOfFunds.self:
        return 'self_funded';
    }
  }
}

class PaymentTimelineResponse extends BaseResponse {
  String? txnId;
  List<UpdateEventHistory>? updateEventHistory;

  PaymentTimelineResponse.error(err) : super.error(err);

  PaymentTimelineResponse({this.txnId, this.updateEventHistory});

  PaymentTimelineResponse.fromJson(dynamic json) {
    txnId = json['txn_id'];
    if (json['update_event_history'] != null) {
      updateEventHistory = <UpdateEventHistory>[];
      json['update_event_history'].forEach((v) {
        updateEventHistory!.add(new UpdateEventHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['txn_id'] = this.txnId;
    if (this.updateEventHistory != null) {
      data['update_event_history'] =
          this.updateEventHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UpdateEventHistory {
  String? status;
  String? updateTimestamp;
  ExtraInfoJson? extraInfoJson;

  UpdateEventHistory({this.status, this.updateTimestamp, this.extraInfoJson});

  UpdateEventHistory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    updateTimestamp = json['update_timestamp'];
    extraInfoJson = json['extra_info_json'] != null
        ? new ExtraInfoJson.fromJson(json['extra_info_json'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['update_timestamp'] = this.updateTimestamp;
    if (this.extraInfoJson != null) {
      data['extra_info_json'] = this.extraInfoJson!.toJson();
    }
    return data;
  }
}

class ExtraInfoJson {
  String? eventCd;
  String? eventId;
  double? amount;
  String? fromCurrency;
  int? transactionCharges;
  String? toCurrency;
  String? statusReason;
  String? reasonCode;
  String? debitedFrom;
  String? creditedTo;
  String? bankId;
  String? beneBankId;
  String? studentId;
  String? purposeId;
  String? beneName;
  List<DocReasons>? docReasons;
  String? expiry;

  ExtraInfoJson(
      {this.eventCd,
      this.eventId,
      this.amount,
      this.fromCurrency,
      this.transactionCharges,
      this.toCurrency,
      this.statusReason,
      this.reasonCode,
      this.debitedFrom,
      this.creditedTo,
      this.bankId,
      this.beneBankId,
      this.studentId,
      this.purposeId,
      this.beneName,
      this.docReasons,
      this.expiry});

  ExtraInfoJson.fromJson(Map<String, dynamic> json) {
    eventCd = json['eventCd'];
    eventId = json['eventId'];
    amount = json['amount'];
    fromCurrency = json['fromCurrency'];
    transactionCharges = json['transactionCharges'];
    toCurrency = json['toCurrency'];
    statusReason = json['statusReason'];
    reasonCode = json['reasonCode'];
    debitedFrom = json['debitedFrom'];
    creditedTo = json['creditedTo'];
    bankId = json['bankId'];
    beneBankId = json['beneBankId'];
    studentId = json['studentId'];
    purposeId = json['purposeId'];
    beneName = json['beneName'];
    if (json['doc_reasons'] != null) {
      docReasons = <DocReasons>[];
      json['doc_reasons'].forEach((v) {
        docReasons!.add(new DocReasons.fromJson(v));
      });
    }
    expiry = json['expiry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventCd'] = this.eventCd;
    data['eventId'] = this.eventId;
    data['amount'] = this.amount;
    data['fromCurrency'] = this.fromCurrency;
    data['transactionCharges'] = this.transactionCharges;
    data['toCurrency'] = this.toCurrency;
    data['statusReason'] = this.statusReason;
    data['reasonCode'] = this.reasonCode;
    data['debitedFrom'] = this.debitedFrom;
    data['creditedTo'] = this.creditedTo;
    data['bankId'] = this.bankId;
    data['beneBankId'] = this.beneBankId;
    data['studentId'] = this.studentId;
    data['purposeId'] = this.purposeId;
    data['beneName'] = this.beneName;
    if (this.docReasons != null) {
      data['doc_reasons'] = this.docReasons!.map((v) => v.toJson()).toList();
    }
    data['expiry'] = this.expiry;
    return data;
  }
}

class DocReasons {
  String? stockalDoctype;
  String? stockalReason;
  String? name;
  String? documentType;
  bool? required;

  DocReasons(
      {this.stockalDoctype,
      this.stockalReason,
      this.name,
      this.documentType,
      this.required});

  DocReasons.fromJson(Map<String, dynamic> json) {
    stockalDoctype = json['stockal_doctype'];
    stockalReason = json['stockal_reason'];
    name = json['name'];
    documentType = json['document_type'];
    required = json['required'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stockal_doctype'] = this.stockalDoctype;
    data['stockal_reason'] = this.stockalReason;
    data['name'] = this.name;
    data['document_type'] = this.documentType;
    data['required'] = this.required;
    return data;
  }
}
