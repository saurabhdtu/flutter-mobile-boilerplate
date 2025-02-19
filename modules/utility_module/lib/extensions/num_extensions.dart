import 'package:intl/intl.dart';

extension CurrencyFormat on num {
  String formatToIntlCurrency({bool withZeroes = false}) {
    final NumberFormat format;
    if (withZeroes) {
      format = NumberFormat('###,###,##0.00', 'en_US');
    } else {
      format = NumberFormat('###,###,###.##', 'en_US');
    }
    return format.format(this);
  }

  String formatToIntlCurrencyWithoutDecimals() {
    final format = NumberFormat('###,###,##0', 'en_US');
    return format.format(this);
  }

  String formatToIndianCurrency() {
    final format = NumberFormat('##,##,##,##,##0.00', 'en_US');
    return format.format(this);
  }

  String invertNumber() {
    return (1 / this).toStringAsFixed(2);
  }
}
