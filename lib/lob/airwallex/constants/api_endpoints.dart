abstract class AWApiEndpoints {
  static const String apiVersion = "/api/v1";
  static const String apiVersionV3 = "/api/v3";
  static const String getRFIData = "$apiVersion/rfidata";
  static const String getTransaction = "$apiVersion/card/%s/transactions";
  static const String getTransactionDetails =
      "$apiVersion/card/transactions/%s";
  static const String getCardDetails = "$apiVersion/card/%s";
  static const String setTransactionLimit =
      "$apiVersion/card/%s/transaction_limits";
  static const String updateCardStatus = "$apiVersion/card/%s/status";
  static const String cardCrud = "$apiVersion/card";
  static const String updateCardNickName = "$apiVersion/card/%s/nickname";
  static const String getCardDetailsAuthToken =
      "$apiVersionV3/connectedaccount/secure_iframe/auth";
  static const String createPaymentRequest =
      "$apiVersionV3/connectedaccount/payment/create";
  static const String getConnectedAccount = "$apiVersionV3/connectedaccount/%s";
  static const String getConnectedAccountDetails =
      "$apiVersionV3/connectedaccount/";
  static const String createConnectedAccount =
      "$apiVersionV3/connectedaccount/create/%s";
  static const String getPassportInfoFront =
      "$apiVersionV3/connectedaccount/files/passport/info/front";
  static const String getPassportInfoBack =
      "$apiVersionV3/connectedaccount/files/passport/info/back";
  static const String uploadDocument =
      "$apiVersionV3/connectedaccount/files/upload";
  static const String getBeneficiaryDetails =
      "$apiVersion/account/beneficiary/%s";
  static const String getBeneficiaryList = "$apiVersion/account/beneficiary";

  // static const String getBeneficiaryFormDetails = "$apiVersionV3/connectedaccount/beneficiary/form/generate";
  static const String getBeneficiaryBankPersonalDetails =
      "$apiVersion/account/beneficiary/form/generate";
  static const String getAccountBalance =
      "$apiVersionV3/connectedaccount/account/balance";
  static const String getConversionQuote =
      "$apiVersionV3/connectedaccount/fx/quote";
  static const String getSupportedCurrency =
      "$apiVersionV3/connectedaccount/currency/%s";
  static const String getBeneficiaryFormDetails =
      "$apiVersion/account/beneficiary/form/generate";
  static const String addNewBeneficiary = "$apiVersion/account/beneficiary";
  static const String createConversion =
      "$apiVersionV3/connectedaccount/conversions/create";
  static const String getWalletTransactionHistory =
      "$apiVersionV3/connectedaccount/transactions/%s";
  static const String addCardHolder =
      "$apiVersionV3/connectedaccount/cardholder/create";
  static const String rfiConnectedAccountDetails =
      "$apiVersionV3/connectedaccount/account/details";
  static const String updateConnectedAccount =
      "$apiVersionV3/connectedaccount/account/update";
  static const String submitConnectedAccount =
      "$apiVersionV3/connectedaccount/account/submit";
}
