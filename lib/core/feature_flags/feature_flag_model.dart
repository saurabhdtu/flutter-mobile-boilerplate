import 'package:network_module/data/responses/responses.dart';

class FeatureResponse extends BaseResponse{
  Remittance? _remittance;
  Airwallex? _airwallex;

  FeatureResponse({Remittance? remittance, Airwallex? airwallex}) {
    if (remittance != null) {
      this._remittance = remittance;
    }
    if (airwallex != null) {
      this._airwallex = airwallex;
    }
  }

  Remittance? get remittance => _remittance;
  set remittance(Remittance? remittance) => _remittance = remittance;
  Airwallex? get airwallex => _airwallex;
  set airwallex(Airwallex? airwallex) => _airwallex = airwallex;

  FeatureResponse.fromJson(Map<String, dynamic> json) {
    _remittance = json['remittance'] != null
        ? new Remittance.fromJson(json['remittance'])
        : null;
    _airwallex = json['airwallex'] != null
        ? new Airwallex.fromJson(json['airwallex'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._remittance != null) {
      data['remittance'] = this._remittance!.toJson();
    }
    if (this._airwallex != null) {
      data['airwallex'] = this._airwallex!.toJson();
    }
    return data;
  }
}

///Remittance Feature Flags
class RemittanceFeatureResponse {
  Remittance? _remittance;

  RemittanceFeatureResponse({Remittance? remittance}) {
    if (remittance != null) {
      this._remittance = remittance;
    }
  }

  Remittance? get remittance => _remittance;
  set remittance(Remittance? remittance) => _remittance = remittance;

  RemittanceFeatureResponse.fromJson(Map<String, dynamic> json) {
    _remittance = json['remittance'] != null
        ? new Remittance.fromJson(json['remittance'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._remittance != null) {
      data['remittance'] = this._remittance!.toJson();
    }
    return data;
  }
}

class Remittance {
  bool? _enabled;
  SendMoney? _sendMoney;
  SendLocal? _addBeneficiary;
  SendLocal? _addRemitter;
  SendLocal? _transactionHistory;

  Remittance(
      {bool? enabled,
        SendMoney? sendMoney,
        SendLocal? addBeneficiary,
        SendLocal? addRemitter,
        SendLocal? transactionHistory}) {
    if (enabled != null) {
      this._enabled = enabled;
    }
    if (sendMoney != null) {
      this._sendMoney = sendMoney;
    }
    if (addBeneficiary != null) {
      this._addBeneficiary = addBeneficiary;
    }
    if (addRemitter != null) {
      this._addRemitter = addRemitter;
    }
    if (transactionHistory != null) {
      this._transactionHistory = transactionHistory;
    }
  }

  bool? get enabled => _enabled;
  set enabled(bool? enabled) => _enabled = enabled;
  SendMoney? get sendMoney => _sendMoney;
  set sendMoney(SendMoney? sendMoney) => _sendMoney = sendMoney;
  SendLocal? get addBeneficiary => _addBeneficiary;
  set addBeneficiary(SendLocal? addBeneficiary) =>
      _addBeneficiary = addBeneficiary;
  SendLocal? get addRemitter => _addRemitter;
  set addRemitter(SendLocal? addRemitter) => _addRemitter = addRemitter;
  SendLocal? get transactionHistory => _transactionHistory;
  set transactionHistory(SendLocal? transactionHistory) =>
      _transactionHistory = transactionHistory;

  Remittance.fromJson(Map<String, dynamic> json) {
    _enabled = json['enabled'];
    _sendMoney = json['send_money'] != null
        ? new SendMoney.fromJson(json['send_money'])
        : null;
    _addBeneficiary = json['add_beneficiary'] != null
        ? new SendLocal.fromJson(json['add_beneficiary'])
        : null;
    _addRemitter = json['add_remitter'] != null
        ? new SendLocal.fromJson(json['add_remitter'])
        : null;
    _transactionHistory = json['transaction_history'] != null
        ? new SendLocal.fromJson(json['transaction_history'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enabled'] = this._enabled;
    if (this._sendMoney != null) {
      data['send_money'] = this._sendMoney!.toJson();
    }
    if (this._addBeneficiary != null) {
      data['add_beneficiary'] = this._addBeneficiary!.toJson();
    }
    if (this._addRemitter != null) {
      data['add_remitter'] = this._addRemitter!.toJson();
    }
    if (this._transactionHistory != null) {
      data['transaction_history'] = this._transactionHistory!.toJson();
    }
    return data;
  }
}

class SendMoney {
  bool? _enabled;
  SendLocal? _sendLocal;
  SendLocal? _sendInternational;

  SendMoney(
      {bool? enabled, SendLocal? sendLocal, SendLocal? sendInternational}) {
    if (enabled != null) {
      this._enabled = enabled;
    }
    if (sendLocal != null) {
      this._sendLocal = sendLocal;
    }
    if (sendInternational != null) {
      this._sendInternational = sendInternational;
    }
  }

  bool? get enabled => _enabled;
  set enabled(bool? enabled) => _enabled = enabled;
  SendLocal? get sendLocal => _sendLocal;
  set sendLocal(SendLocal? sendLocal) => _sendLocal = sendLocal;
  SendLocal? get sendInternational => _sendInternational;
  set sendInternational(SendLocal? sendInternational) =>
      _sendInternational = sendInternational;

  SendMoney.fromJson(Map<String, dynamic> json) {
    _enabled = json['enabled'];
    _sendLocal = json['send_local'] != null
        ? new SendLocal.fromJson(json['send_local'])
        : null;
    _sendInternational = json['send_international'] != null
        ? new SendLocal.fromJson(json['send_international'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enabled'] = this._enabled;
    if (this._sendLocal != null) {
      data['send_local'] = this._sendLocal!.toJson();
    }
    if (this._sendInternational != null) {
      data['send_international'] = this._sendInternational!.toJson();
    }
    return data;
  }
}

class SendLocal {
  bool? _enabled;

  SendLocal({bool? enabled}) {
    if (enabled != null) {
      this._enabled = enabled;
    }
  }

  bool? get enabled => _enabled;
  set enabled(bool? enabled) => _enabled = enabled;

  SendLocal.fromJson(Map<String, dynamic> json) {
    _enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enabled'] = this._enabled;
    return data;
  }
}


///AirWallex Feature Flags
class AirwallexFeatureResponse {
  Airwallex? _airwallex;

  AirwallexFeatureResponse({Airwallex? airwallex}) {
    if (airwallex != null) {
      this._airwallex = airwallex;
    }
  }

  Airwallex? get airwallex => _airwallex;
  set airwallex(Airwallex? airwallex) => _airwallex = airwallex;

  AirwallexFeatureResponse.fromJson(Map<String, dynamic> json) {
    _airwallex = json['airwallex'] != null
        ? new Airwallex.fromJson(json['airwallex'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._airwallex != null) {
      data['airwallex'] = this._airwallex!.toJson();
    }
    return data;
  }
}

class Airwallex {
  bool? _enabled;
  AddCard? _addCard;
  BlockCard? _addBeneficiary;
  BlockCard? _makePayment;

  Airwallex(
      {bool? enabled,
        AddCard? addCard,
        BlockCard? addBeneficiary,
        BlockCard? makePayment}) {
    if (enabled != null) {
      this._enabled = enabled;
    }
    if (addCard != null) {
      this._addCard = addCard;
    }
    if (addBeneficiary != null) {
      this._addBeneficiary = addBeneficiary;
    }
    if (makePayment != null) {
      this._makePayment = makePayment;
    }
  }

  bool? get enabled => _enabled;
  set enabled(bool? enabled) => _enabled = enabled;
  AddCard? get addCard => _addCard;
  set addCard(AddCard? addCard) => _addCard = addCard;
  BlockCard? get addBeneficiary => _addBeneficiary;
  set addBeneficiary(BlockCard? addBeneficiary) =>
      _addBeneficiary = addBeneficiary;
  BlockCard? get makePayment => _makePayment;
  set makePayment(BlockCard? makePayment) => _makePayment = makePayment;

  Airwallex.fromJson(Map<String, dynamic> json) {
    _enabled = json['enabled'];
    _addCard = json['add_card'] != null
        ? new AddCard.fromJson(json['add_card'])
        : null;
    _addBeneficiary = json['add_beneficiary'] != null
        ? new BlockCard.fromJson(json['add_beneficiary'])
        : null;
    _makePayment = json['make_payment'] != null
        ? new BlockCard.fromJson(json['make_payment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enabled'] = this._enabled;
    if (this._addCard != null) {
      data['add_card'] = this._addCard!.toJson();
    }
    if (this._addBeneficiary != null) {
      data['add_beneficiary'] = this._addBeneficiary!.toJson();
    }
    if (this._makePayment != null) {
      data['make_payment'] = this._makePayment!.toJson();
    }
    return data;
  }
}

class AddCard {
  bool? _enabled;
  BlockCard? _blockCard;
  BlockCard? _freezeCard;
  BlockCard? _limitCard;

  AddCard(
      {bool? enabled,
        BlockCard? blockCard,
        BlockCard? freezeCard,
        BlockCard? limitCard}) {
    if (enabled != null) {
      this._enabled = enabled;
    }
    if (blockCard != null) {
      this._blockCard = blockCard;
    }
    if (freezeCard != null) {
      this._freezeCard = freezeCard;
    }
    if (limitCard != null) {
      this._limitCard = limitCard;
    }
  }

  bool? get enabled => _enabled;
  set enabled(bool? enabled) => _enabled = enabled;
  BlockCard? get blockCard => _blockCard;
  set blockCard(BlockCard? blockCard) => _blockCard = blockCard;
  BlockCard? get freezeCard => _freezeCard;
  set freezeCard(BlockCard? freezeCard) => _freezeCard = freezeCard;
  BlockCard? get limitCard => _limitCard;
  set limitCard(BlockCard? limitCard) => _limitCard = limitCard;

  AddCard.fromJson(Map<String, dynamic> json) {
    _enabled = json['enabled'];
    _blockCard = json['block_card'] != null
        ? new BlockCard.fromJson(json['block_card'])
        : null;
    _freezeCard = json['freeze_card'] != null
        ? new BlockCard.fromJson(json['freeze_card'])
        : null;
    _limitCard = json['limit_card'] != null
        ? new BlockCard.fromJson(json['limit_card'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enabled'] = this._enabled;
    if (this._blockCard != null) {
      data['block_card'] = this._blockCard!.toJson();
    }
    if (this._freezeCard != null) {
      data['freeze_card'] = this._freezeCard!.toJson();
    }
    if (this._limitCard != null) {
      data['limit_card'] = this._limitCard!.toJson();
    }
    return data;
  }
}

class BlockCard {
  bool? _enabled;

  BlockCard({bool? enabled}) {
    if (enabled != null) {
      this._enabled = enabled;
    }
  }

  bool? get enabled => _enabled;
  set enabled(bool? enabled) => _enabled = enabled;

  BlockCard.fromJson(Map<String, dynamic> json) {
    _enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enabled'] = this._enabled;
    return data;
  }
}
