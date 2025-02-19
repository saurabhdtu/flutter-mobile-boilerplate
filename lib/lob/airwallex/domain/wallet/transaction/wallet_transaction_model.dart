import 'package:network_module/data/responses/responses.dart';
import 'package:zinc/lob/airwallex/constants/strings.dart';

class TransactionHistoryResponse extends BaseResponse {
  TransactionHistoryResponse.error(error) : super.error(error);

  bool? _hasMore;
  List<WalletTransactionItem>? _items;

  TransactionHistoryResponse(
      {bool? hasMore, List<WalletTransactionItem>? items}) {
    if (hasMore != null) {
      this._hasMore = hasMore;
    }
    if (items != null) {
      this._items = items;
    }
  }

  bool? get hasMore => _hasMore;

  set hasMore(bool? hasMore) => _hasMore = hasMore;

  List<WalletTransactionItem> get items => _items ?? [];

  set items(List<WalletTransactionItem>? items) => _items = items;

  TransactionHistoryResponse.fromJson(dynamic json) {
    _hasMore = json['has_more'];
    if (json['items'] != null) {
      _items = <WalletTransactionItem>[];
      json['items'].forEach((v) {
        _items!.add(new WalletTransactionItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['has_more'] = this._hasMore;
    if (this._items != null) {
      data['items'] = this._items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WalletTransactionItem {
  String? _id;
  String? _sourceId;
  String? _sourceType;
  String? _transactionType;
  String? _currency;
  num? _amount;
  String? _currencyPair;
  num? _net;
  num? _fee;
  String? _settledAt;
  String? _description;
  String? _status;
  String? _createdAt;

  WalletTransactionItem(
      {String? id,
      String? sourceId,
      String? sourceType,
      String? transactionType,
      String? currency,
      num? amount,
      String? currencyPair,
      num? net,
      num? fee,
      String? settledAt,
      String? description,
      String? status,
      String? createdAt}) {
    if (id != null) {
      this._id = id;
    }

    if (sourceId != null) {
      this._sourceId = sourceId;
    }
    if (sourceType != null) {
      this._sourceType = sourceType;
    }
    if (transactionType != null) {
      this._transactionType = transactionType;
    }
    if (currency != null) {
      this._currency = currency;
    }
    if (amount != null) {
      this._amount = amount;
    }
    if (currencyPair != null) {
      this._currencyPair = currencyPair;
    }
    if (net != null) {
      this._net = net;
    }
    if (fee != null) {
      this._fee = fee;
    }

    if (settledAt != null) {
      this._settledAt = settledAt;
    }
    if (description != null) {
      this._description = description;
    }
    if (status != null) {
      this._status = status;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
  }

  String get id => _id ?? "";

  set id(String? id) => _id = id;

  String? get sourceId => _sourceId;

  set sourceId(String? sourceId) => _sourceId = sourceId;

  String get sourceType => _sourceType ?? "";

  set sourceType(String? sourceType) => _sourceType = sourceType;

  String? get transactionType => _transactionType;

  set transactionType(String? transactionType) =>
      _transactionType = transactionType;

  String get currency => _currency ?? "";

  set currency(String? currency) => _currency = currency;

  num get amount => _amount ?? 0;

  set amount(num? amount) => _amount = amount;

  String? get currencyPair => _currencyPair;

  set currencyPair(String? currencyPair) => _currencyPair = currencyPair;

  num get net => _net ?? 0;

  set net(num? net) => _net = net;

  num get fee => _fee ?? 0;

  set fee(num? fee) => _fee = fee;

  String? get settledAt => _settledAt;

  set settledAt(String? settledAt) => _settledAt = settledAt;

  String get description => _description != null && _description != ""
      ? _description!
      : AWStrings.noTitle;

  set description(String? description) => _description = description;

  String? get status => _status;

  set status(String? status) => _status = status;

  String get createdAt => _createdAt ?? "";

  set createdAt(String? createdAt) => _createdAt = createdAt;

  WalletTransactionItem.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _sourceId = json['source_id'];
    _sourceType = json['source_type'];
    _transactionType = json['transaction_type'];
    _currency = json['currency'];
    _amount = json['amount'];
    _currencyPair = json['currency_pair'];
    _net = json['net'];
    _fee = json['fee'];
    _settledAt = json['settled_at'];
    _description = json['description'];
    _status = json['status'];
    _createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['source_id'] = this._sourceId;
    data['source_type'] = this._sourceType;
    data['transaction_type'] = this._transactionType;
    data['currency'] = this._currency;
    data['amount'] = this._amount;
    data['currency_pair'] = this._currencyPair;
    data['net'] = this._net;
    data['fee'] = this._fee;
    data['settled_at'] = this._settledAt;
    data['description'] = this._description;
    data['status'] = this._status;
    data['created_at'] = this._createdAt;
    return data;
  }
}

enum WalletTransactionStatus { PENDING, SETTLED, CANCELLED }

enum WalletTransactionSourceType {
  PAYOUT,
  CONVERSION,
  DEPOSIT,
  ADJUSTMENT,
  FEE,
  PAYMENT_ATTEMPT,
  REFUND,
  DISPUTE,
  CHARGE,
  TRANSFER,
  YIELD,
  BATCH_PAYOUT,
  CARD_PURCHASE,
  CARD_REFUND,
  PURCHASE,
  REFUND_REVERSAL
}

WalletTransactionStatus getWalletTransactionStatus(String? status) {
  switch (status?.toUpperCase().trim()) {
    case "SETTLED":
      return WalletTransactionStatus.SETTLED;
    case "CANCELLED":
      return WalletTransactionStatus.CANCELLED;
    case "PENDING":
      return WalletTransactionStatus.PENDING;
    default:
      return WalletTransactionStatus.CANCELLED;
  }
}

WalletTransactionSourceType getWalletTransactionSourceType(String? sourceType) {
  switch (sourceType?.toUpperCase().trim()) {
    case "PAYOUT":
      return WalletTransactionSourceType.PAYOUT;
    case "CONVERSION":
      return WalletTransactionSourceType.CONVERSION;
    case "DEPOSIT":
      return WalletTransactionSourceType.DEPOSIT;
    case "ADJUSTMENT":
      return WalletTransactionSourceType.ADJUSTMENT;
    case "FEE":
      return WalletTransactionSourceType.FEE;
    case "PAYMENT_ATTEMPT":
      return WalletTransactionSourceType.PAYMENT_ATTEMPT;
    case "REFUND":
      return WalletTransactionSourceType.REFUND;
    case "DISPUTE":
      return WalletTransactionSourceType.DISPUTE;
    case "CHARGE":
      return WalletTransactionSourceType.CHARGE;
    case "TRANSFER":
      return WalletTransactionSourceType.TRANSFER;
    case "YIELD":
      return WalletTransactionSourceType.YIELD;
    case "BATCH_PAYOUT":
      return WalletTransactionSourceType.BATCH_PAYOUT;
    case "CARD_PURCHASE":
      return WalletTransactionSourceType.CARD_PURCHASE;
    case "CARD_REFUND":
      return WalletTransactionSourceType.CARD_REFUND;
    case "PURCHASE":
      return WalletTransactionSourceType.PURCHASE;
    case "REFUND_REVERSAL":
      return WalletTransactionSourceType.REFUND_REVERSAL;
    default:
      return WalletTransactionSourceType.PAYOUT;
  }
}
