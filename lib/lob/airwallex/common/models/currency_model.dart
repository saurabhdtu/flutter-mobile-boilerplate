class CurrencyUiModel {
  final String currencyLogoUrl;
  final String currencyCode;
  final String currencyName;
  final String currencySymbol;
  final String? displayBalance;
  final num? balance;

  CurrencyUiModel(
      {required this.currencyLogoUrl,
      required this.currencyCode,
      required this.currencyName,
      required this.currencySymbol,
      this.balance,
      this.displayBalance});

}
