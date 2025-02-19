import 'package:analytics_module/constants.dart';

import 'base_event.dart';

class AppLaunchEvent extends BaseAnalyticsEvent {
  AppLaunchEvent(Map<String, dynamic>? properties)
      : super.event(eventName: "app_launched", properties: properties);
}

class PageLoadEvent extends BaseAnalyticsEvent {
  PageLoadEvent(String pageName,
      {String? receiverType,
      String? pageData,
      String? errorType,
      String? cardLimitType,
      String? maskedCardNumber,
      String? cardTxnId,
      String? pageState})
      : super.event(eventName: "page_load", properties: {
          "page_name": pageName,
          "page_data": pageData,
          "page_state": pageState,
          "receiver_type": receiverType,
          "awx_card_last_4_digits": maskedCardNumber,
          "error_type": errorType,
          "awx_card_limit_type": cardLimitType,
          "awx_card_txn_id": cardTxnId
        });
}

class ButtonClickEvent extends BaseAnalyticsEvent {
  ButtonClickEvent(String pageName, String buttonName,
      {String? receiverReason,
      String? bottomSheetName,
      String? pageState,
      String? cardLimitType,
      String? cardLastDigits,
      String? selectedCurrency,
      String? selectedCountry,
      String? paymentMethod,
      String? awxBeneId,
      String? payoutReason,
      String? payoutSourceCurrency,
      String? payoutBeneCurrency,
      String? payoutFees,
      num? payoutSourceAmount,
      num? payoutBeneAmount,
      bool? payoutFxInvolved,
      EventButtonType? buttonType})
      : super.event(eventName: "button_click", properties: {
          "page_name": pageName,
          "button_name": buttonName,
          "receiver_reason": receiverReason,
          "bottom_sheet_name": bottomSheetName,
          "page_state": pageState,
          "button_type": buttonType?.toString(),
          "awx_card_limit_type": cardLimitType,
          "awx_card_last_4_digits": cardLastDigits,
          "selected_bene_currency": selectedCurrency,
          "selected_bene_country": selectedCountry,
          "awx_payment_method": paymentMethod,
          "awx_bene_id": awxBeneId,
          "awx_payout_reason": payoutReason,
          "awx_payout_source_currency": payoutSourceCurrency,
          "awx_payout_source_amount": payoutSourceAmount,
          "awx_payout_bene_currency": payoutBeneCurrency,
          "awx_payout_bene_amount": payoutBeneAmount,
          "awx_payout_fx_involved": payoutFxInvolved,
          "awx_payout_fees": payoutFees,
        });
}

class FormExitEvent extends BaseAnalyticsEvent {
  FormExitEvent(String pageName)
      : super.event(
            eventName: "form_exit", properties: {"page_name": pageName});
}

class APIResponseEvent extends BaseAnalyticsEvent {
  APIResponseEvent(String pageName, String serverStatus,
      {String? buttonName,
      String? errorDescription,
      int? failureCode,
      String? receiverType})
      : super.event(eventName: "api_response", properties: {
          "page_name": pageName,
          "button_name": buttonName,
          "server_status": serverStatus,
          "error_description": errorDescription,
          "error_status_code": failureCode,
          "receiver_type": receiverType
        });
}

class AutoFillEvent extends BaseAnalyticsEvent {
  AutoFillEvent(String pageName, String dataType)
      : super.event(
            eventName: "auto_fill",
            properties: {"page_name": pageName, "data_type": dataType});
}

class BottomSheetLoadEvent extends BaseAnalyticsEvent {
  BottomSheetLoadEvent(String pageName, String bottomSheetName,
      {String? pageState})
      : super.event(eventName: "bottom_sheet_load", properties: {
          "page_name": pageName,
          "bottom_sheet_name": bottomSheetName,
          "page_state": pageState
        });
}

class LoginEvent extends BaseAnalyticsEvent {
  LoginEvent(String id)
      : super.event(
            eventName: "login",
            properties: {"id": id},
            platformsToTrack: [AMPlatform.moengage]);
}

class ScreenTimeTrackingEvent extends BaseAnalyticsEvent {
  ScreenTimeTrackingEvent(String pageName, int timeSpentInSeconds)
      : super.event(eventName: "time_spent_on_page", properties: {
          "page_name": pageName,
          "time_spent_in_seconds": timeSpentInSeconds
        });
}

class ScreenScrollTrackingEvent extends BaseAnalyticsEvent {
  ScreenScrollTrackingEvent(String pageName, int maxScrollPercentage)
      : super.event(eventName: "scroll_metrics_on_page", properties: {
          "page_name": pageName,
          "max_scroll_percentage": maxScrollPercentage,
          "items": []
        });
}

enum EventButtonType { link, button, radioButton, cta, banner, video }

class AppsFlyerEvent extends BaseAnalyticsEvent {
  const AppsFlyerEvent.event(String eventName)
      : super.event(eventName: eventName);
  static const AppsFlyerEvent signupComplete =
      AppsFlyerEvent.event("Signup Complete");
  static const AppsFlyerEvent basicProfileComplete =
      AppsFlyerEvent.event("Basic Profile Complete");
  static const AppsFlyerEvent senderDigiLockerComplete =
      AppsFlyerEvent.event("Sender Digilocker Complete");
  static const AppsFlyerEvent senderPANComplete =
      AppsFlyerEvent.event("Sender PAN Complete");
  static const AppsFlyerEvent studentVerificationComplete =
      AppsFlyerEvent.event("Student Verification Complete");
  static const AppsFlyerEvent addNewSenderComplete =
      AppsFlyerEvent.event("Add New Sender Complete");
  static const AppsFlyerEvent addNewReceiverComplete =
      AppsFlyerEvent.event("Add New Receiver Complete");
  static const AppsFlyerEvent txnPGSuccess =
      AppsFlyerEvent.event("Transaction PG Success");
}
