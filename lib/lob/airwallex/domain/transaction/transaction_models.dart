import 'package:network_module/data/responses/responses.dart';

// TODO change this when we get actual response from api

class CardTransactionResponse extends BaseResponse {
  CardTransactionResponse.error(error) : super.error(error);

  CardTransactionResponse({
    bool? hasMore,
    List<TransactionItem>? items,
  }) {
    _hasMore = hasMore;
    _items = items;
  }

  CardTransactionResponse.fromJson(dynamic json) {
    _hasMore = json['has_more'];
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(TransactionItem.fromJson(v));
      });
    }
  }

  bool? _hasMore;
  List<TransactionItem>? _items;

  bool? get hasMore => _hasMore;

  List<TransactionItem>? get list => _items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['has_more'] = _hasMore;
    if (_items != null) {
      map['items'] = _items?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class TransactionItem {
  TransactionItem({
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

  TransactionItem.fromJson(dynamic json) {
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

  String? get status => _status;

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

class Merchant {
  Merchant({
    String? categoryCode,
    String? city,
    String? country,
    String? name,
  }) {
    _categoryCode = categoryCode;
    _city = city;
    _country = country;
    _name = name;
  }

  Merchant.fromJson(dynamic json) {
    _categoryCode = json['category_code'];
    _city = json['city'];
    _country = json['country'];
    _name = json['name'];
  }

  String? _categoryCode;
  String? _city;
  String? _country;
  String? _name;

  String? get categoryCode => _categoryCode;

  String? get city => _city;

  String? get country => _country;

  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category_code'] = _categoryCode;
    map['city'] = _city;
    map['country'] = _country;
    map['name'] = _name;
    return map;
  }
}

enum CardTransactionStatus {
  APPROVED,
  CLEARED,
  EXPIRED,
  FAILED,
  PENDING,
  REVERSED,
  UNKNOWN
}

///end
