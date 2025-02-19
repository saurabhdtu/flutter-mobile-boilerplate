import 'package:network_module/data/responses/responses.dart';
import 'package:zinc/lob/airwallex/domain/transaction/transaction_models.dart';

// TODO change this when we get actual response from api

class TransactionDetailsResponse extends BaseResponse {
  TransactionDetailsResponse.error(error) : super.error(error);

  TransactionDetailsResponse({
    String? authCode,
    num? billingAmount,
    String? billingCurrency,
    String? cardId,
    String? cardNickname,
    String? failureReason,
    String? maskedCardNumber,
    Merchant? merchant,
    String? networkTransactionId,
    String? postedDate,
    String? retrievalRef,
    String? status,
    num? transactionAmount,
    String? transactionCurrency,
    String? transactionDate,
    String? transactionId,
    String? transactionType,
  }) {
    _authCode = authCode;
    _billingAmount = billingAmount;
    _billingCurrency = billingCurrency;
    _cardId = cardId;
    _cardNickname = cardNickname;
    _failureReason = failureReason;
    _maskedCardNumber = maskedCardNumber;
    _merchant = merchant;
    _networkTransactionId = networkTransactionId;
    _postedDate = postedDate;
    _retrievalRef = retrievalRef;
    _status = status;
    _transactionAmount = transactionAmount;
    _transactionCurrency = transactionCurrency;
    _transactionDate = transactionDate;
    _transactionId = transactionId;
    _transactionType = transactionType;
  }

  TransactionDetailsResponse.fromJson(dynamic json) {
    _authCode = json['auth_code'];
    _billingAmount = json['billing_amount'];
    _billingCurrency = json['billing_currency'];
    _cardId = json['card_id'];
    _cardNickname = json['card_nickname'];
    _failureReason = json['failure_reason'];
    _maskedCardNumber = json['masked_card_number'];
    _merchant =
        json['merchant'] != null ? Merchant.fromJson(json['merchant']) : null;
    _networkTransactionId = json['network_transaction_id'];
    _postedDate = json['posted_date'];
    _retrievalRef = json['retrieval_ref'];
    _status = json['status'];
    _transactionAmount = json['transaction_amount'];
    _transactionCurrency = json['transaction_currency'];
    _transactionDate = json['transaction_date'];
    _transactionId = json['transaction_id'];
    _transactionType = json['transaction_type'];
  }

  String? _authCode;
  num? _billingAmount;
  String? _billingCurrency;
  String? _cardId;
  String? _cardNickname;
  String? _failureReason;
  String? _maskedCardNumber;
  Merchant? _merchant;
  String? _networkTransactionId;
  String? _postedDate;
  String? _retrievalRef;
  String? _status;
  num? _transactionAmount;
  String? _transactionCurrency;
  String? _transactionDate;
  String? _transactionId;
  String? _transactionType;

  String? get authCode => _authCode;

  num? get billingAmount => _billingAmount;

  String? get billingCurrency => _billingCurrency;

  String? get cardId => _cardId;

  String? get cardNickname => _cardNickname;

  String? get failureReason => _failureReason;

  String? get maskedCardNumber => _maskedCardNumber;

  Merchant? get merchant => _merchant;

  String? get networkTransactionId => _networkTransactionId;

  String? get postedDate => _postedDate;

  String? get retrievalRef => _retrievalRef;

  String? get transactionStatus => _status;

  num? get transactionAmount => _transactionAmount;

  String? get transactionCurrency => _transactionCurrency;

  String? get transactionDate => _transactionDate;

  String? get transactionId => _transactionId;

  String? get transactionType => _transactionType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['auth_code'] = _authCode;
    map['billing_amount'] = _billingAmount;
    map['billing_currency'] = _billingCurrency;
    map['card_id'] = _cardId;
    map['card_nickname'] = _cardNickname;
    map['failure_reason'] = _failureReason;
    map['masked_card_number'] = _maskedCardNumber;
    if (_merchant != null) {
      map['merchant'] = _merchant?.toJson();
    }
    map['network_transaction_id'] = _networkTransactionId;
    map['posted_date'] = _postedDate;
    map['retrieval_ref'] = _retrievalRef;
    map['status'] = _status;
    map['transaction_amount'] = _transactionAmount;
    map['transaction_currency'] = _transactionCurrency;
    map['transaction_date'] = _transactionDate;
    map['transaction_id'] = _transactionId;
    map['transaction_type'] = _transactionType;
    return map;
  }
}

CardTransactionStatus getTransactionStatus(String? status) {
  switch (status?.toUpperCase().trim()) {
    case "APPROVED":
      return CardTransactionStatus.APPROVED;
    case "CLEARED":
      return CardTransactionStatus.CLEARED;
    case "EXPIRED":
      return CardTransactionStatus.EXPIRED;
    case "PENDING":
      return CardTransactionStatus.PENDING;
    case "REVERSED":
      return CardTransactionStatus.REVERSED;
    default:
      return CardTransactionStatus.UNKNOWN;
  }
}
