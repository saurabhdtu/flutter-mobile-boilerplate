import 'package:network_module/data/responses/responses.dart';

class CountriesResponse extends BaseResponse {
  CountriesResponse.error(err) : super.error(err);
  List<Country>? _countries;

  CountriesResponse(this._countries);

  factory CountriesResponse.fromJson(dynamic json) {
    return CountriesResponse(
        (json is List) ? json.map((e) => Country.fromJson(e)).toList() : []);
  }

  List<Country> get countries => _countries ?? [];
}

class Country extends BaseResponse{
  Country.error(err) : super.error(err);
  Country({
    num? id,
    String? name,
    String? isoAlpha2,
    String? isoAlpha3,
    num? isoNumeric,
    Currency? currency,
    String? flag,
  }) {
    _id = id;
    _name = name;
    _isoAlpha2 = isoAlpha2;
    _isoAlpha3 = isoAlpha3;
    _isoNumeric = isoNumeric;
    _currency = currency;
    _flag = flag;
  }

  Country.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _isoAlpha2 = json['isoAlpha2'];
    _isoAlpha3 = json['isoAlpha3'];
    _isoNumeric = json['isoNumeric'];
    _currency =
        json['currency'] != null ? Currency.fromJson(json['currency']) : null;
    _flag = json['flag'];
  }

  num? _id;
  String? _name;
  String? _isoAlpha2;
  String? _isoAlpha3;
  num? _isoNumeric;
  Currency? _currency;
  String? _flag;

  num? get id => _id;

  String? get name => _name;

  String? get isoAlpha2 => _isoAlpha2;

  String? get isoAlpha3 => _isoAlpha3;

  num? get isoNumeric => _isoNumeric;

  Currency? get currency => _currency;

  String? get flag => _flag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['isoAlpha2'] = _isoAlpha2;
    map['isoAlpha3'] = _isoAlpha3;
    map['isoNumeric'] = _isoNumeric;
    if (_currency != null) {
      map['currency'] = _currency?.toJson();
    }
    map['flag'] = _flag;
    return map;
  }
}

class Currency {
  Currency({
    String? code,
    String? name,
    String? symbol,
  }) {
    _code = code;
    _name = name;
    _symbol = symbol;
  }

  Currency.fromJson(dynamic json) {
    _code = json['code'];
    _name = json['name'];
    _symbol = json['symbol']?.toString();
  }

  String? _code;
  String? _name;
  String? _symbol;

  String? get code => _code;

  String? get name => _name;

  String? get symbol => _symbol;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['name'] = _name;
    map['symbol'] = _symbol;
    return map;
  }
}
