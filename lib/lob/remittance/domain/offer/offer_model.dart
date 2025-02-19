import 'package:network_module/data/responses/responses.dart';

class OfferResponse extends BaseResponse {
  OfferResponse.error(error):super.error(error);

  OfferResponse.fromJson(dynamic json) {
    _cardHeader = json['card_header']?.toString();
    _cardTitle = json['card_title']?.toString();
    _cardSubtitle = json['card_subtitle']?.toString();
  }
  String? _cardHeader;
  String? _cardTitle;
  String? _cardSubtitle;

  String get cardHeader => _cardHeader??"";
  String get cardTitle => _cardTitle??"";
  String get cardSubtitle => _cardSubtitle??"";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['card_header'] = _cardHeader;
    map['card_title'] = _cardTitle;
    map['card_subtitle'] = _cardSubtitle;
    return map;
  }

}