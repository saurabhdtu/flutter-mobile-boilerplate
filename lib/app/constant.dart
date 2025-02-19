import 'package:flutter/services.dart';

abstract class Constant {
  static const String token = "get api token here";
  static const String referenceId = "reference_id";
  static const String phoneNumber = "phone_number";
  static const String email = "email";
  static const String INPUT_EMAIL = 'email';
  static const String INPUT_PHONE = 'phone';
  static const int otpLength = 6;
  static const int otpRetrySec = 30;
  static const String passportDocumentType = 'PASSPORT_FRONT_AND_BACK';

  static const String backIconPressed = "backIconPressed";
  static const String pageResultSuccess = "success";
  static const String pageResultError = "error";
  static const String pageResultRefresh = "refresh";
}

abstract class Regex {
  static const emailRegex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const mobileRegex = r'(^[6-9][0-9]{9}$)';
  static const swiftRegex = r'^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$';
  static const otpRegex = r'^(\d{6})';
  static const nameRegex =
      r'^[a-zA-Z\s]*$'; // First and Last name (alphanumeric, no special characters)
  static const passportNumberRegex =
      r'^[a-zA-Z0-9]{8}$'; // Passport number should be alphanumeric, 8-9 characters
  static const dateRegex =
      r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[012])/\d{4}$'; // Date format in DD/MM/YYYY
  static const postalCodeRegex =
      r'^\d{6}$'; // Postal code should be exactly 6 digits
  static const addressRegex =
      r'^[a-zA-Z0-9\s,.-]+$'; // Address line allowing alphanumeric, spaces, commas, periods, hyphens
  static const mrzLine1Regex =
      r'^P<([A-Z]{3})([A-Z<]+)<<([A-Z<]+)<([A-Z<]+)<<<<<<<<<<<<<<<<<<$';
  static const mrzLine2Regex =
      r'^[A-Z0-9<]{9}[0-9][A-Z]{3}[0-9]{6}[0-9][MF<][0-9]{6}[0-9][A-Z0-9<]{15}[0-9]$';
}

abstract class Countries {
  static const usa = "United States of America";
  static const canada = "Canada";
  static const uk = "United Kingdom";
  static const aus = "Australia";
  static const france = "France";
  static const ger = "Germany";
  static const italy = "Italy";
  static const ireland = "Ireland";
}

abstract class AppMethodChannel {
  static const MethodChannel platformChannel =
      MethodChannel("com.zinc.money/platform");
  static const MethodChannel screenChannel =
      MethodChannel("com.zinc.money/screen");
  static const MethodChannel jailBreakDetection =
      MethodChannel("flutter_jailbreak_detection");
  static const methodStartSmsRetriever = "start_sms_retriever";
  static const methodGetConfig = "get_config";
  static const methodPhoneNumberHint = "phone_number_hint";
  static const interceptorOnSmsReceived = "on_sms_received";
  static const jailBroken = "jailbroken";
  static const developerMode = "developerMode";
}
