import 'package:common_module/remote_config.dart';
import 'package:design_module/old_design/resources/color_manager.dart';
import 'package:utility_module/extensions/string_extensions.dart';
import 'package:design_module/widget/zinc_icons.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
class BankIcons {
  List<BankIcon>? icons;

  BankIcons.fromJson(dynamic json) {
    icons = json == null
        ? <BankIcon>[]
        : (json as List).map((e) => BankIcon.fromJson(e)).toList();
  }
}

class BankIcon {
  BankIcon.fromJson(dynamic json) {
    _bank = json['bank'];
    _icon = json['icon'];
  }

  String? _bank;
  String? _icon;

  String? get bank => _bank;

  String? get icon => _icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bank'] = _bank;
    map['icon'] = _icon;
    return map;
  }
}

Widget zincBankIcon(String bankName,
    {final double size = 32,
      final String icon = "ic_bank.svg",
      final Color bgColor = ColorManager.colorE3FFED,
      final iconColor = ColorManager.color09B447}) {
  final String? bankImageUrl = bankName.getBankURLForBankName();
  if (bankImageUrl != null) {
    return CachedNetworkImage(
        imageUrl: bankImageUrl, width: size, height: size, fit: BoxFit.contain);
  } else {
    return zincSvg(icon, height: size, width: size);
  }
}
extension bankName on String{

  String? getBankURLForBankName() {
    BankIcons bankIcons = RemoteConfigManager.getInstance.getJsonData(
        RemoteConfigKeys.bankIcons, (p0) => BankIcons.fromJson(p0));
    for (BankIcon bankIcon in bankIcons.icons ?? []) {
      int dist = bankIcon.bank
              ?.toLowerCase()
              .levenshteinDistance(this.toLowerCase()) ??
          0;
      if (dist <= (this.length * 0.3)) {
        return bankIcon.icon;
      }
    }
    return null;
  }
}
