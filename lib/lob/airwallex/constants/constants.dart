abstract class Constants {
  static String CONNECTED_CARD_ID = "2bc28849-dd00-442a-9022-9e72c075d935";
  static String CONNECTED_ACCOUNT_ID = "acct_dgK0wTQINoK6QFkg61EUjQ";
  // static String CONNECTED_CARD_ID = "2bc28849-dd00-442a-9022-9e72c075d935";
  // static String MOBILE_NUMBER = "91-9090909090";
  // static String CONNECTED_ACCOUNT_ID = "acct_nMy4ZtMNMTm27Q_C2-tEdQ";
  static String EMAIL = "asojkn@gmail.com";
  static String CARD_HOLDER_ID = "";
  static String X_API_VERSION = "2024-08";

  static const String BENEFICIARY_ID = "e9e5a020-f3df-45ea-ab63-939879b71f54";
  static const String PAYMENT_METHOD = "SWIFT";
  static const String SAMPLE_ILLUSTRATION_URL =
      "https://storage.googleapis.com/zinc-money-prod.appspot.com/app-image-assets/airwallex/ic_sample_illustration.png";
  static const Duration exchangeRateRefreshDuration =
      const Duration(minutes: 15);

  static const minConversionAmount = 1000;
  static num TRANSACTION_LIST_PAGE_SIZE = 10;
}

abstract class CardLimitsInterval {
  static const String ALL_TIME_INTERVAL = "ALL_TIME";
  static const String PER_TRANSACTION_INTERVAL = "PER_TRANSACTION";
  static const String DAILY_INTERVAL = "DAILY";
  static const String WEEKLY_INTERVAL = "WEEKLY";
  static const String MONTHLY_INTERVAL = "MONTHLY";
}

abstract class BeneficiaryFormFieldType {
  static const String bankCountryCode = "BANK_COUNTRY_CODE";
  static const String entityType = "ENTITY_TYPE";
  static const String accountCurrency = "ACCOUNT_CURRENCY";
  static const String paymentMethod = "PAYMENT_METHOD";
  static const String localClearingSystem = "LOCAL_CLEARING_SYSTEM";
}

abstract class BeneficiaryPaymentType {
  static const String Local = "LOCAL";
  static const String Swift = "SWIFT";
}

class RfiKeys {
  // Keys for file requirements
  static const String primaryIdentificationRequired =
      'primaryIdentificationRequired';
  static const String photoHoldingIdRequired = 'photoHoldingIdRequired';
  static const String photoFileIdRequired = 'photoFileIdRequired';
  static const String secondaryIdentificationRequired =
      'secondaryIdentificationRequired';
  // Keys for text field data
  static const String reasonForDuplicateAccount =
      'reason_for_duplicate_account_required';
}
