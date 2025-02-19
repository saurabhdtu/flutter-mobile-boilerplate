abstract class UtilityStrings {
  //App update screen
  static const String updateNow = "Update Now";
  static const String remindMeLater = "Remind Me Later";
  static const String appUpdateDialogDescription =
      "A new version of the app is ready for installation. To ensure you have the latest features and improvements, please update now.";
  static const String updateAvailableExclamantion = "Update Available!";

  static const String enterValidEmail = "Please enter a valid email address";
  static const String enterEmail = "Please enter your email";

  // Validation Error Messages
  static const String firstNameError = "Enter your first name";
  static const String enterPassport = "Enter passport number";
  static const String passportNumberError = "Enter a valid passport number";
  static const String issueDateError = "Enter a valid passport issue date";
  static const String expiryDateError = "Enter a valid passport expiry date";

  // Error messages for address fields validation
  static const String addressError = "Enter address as on passport";
  static const String invalidAddressError =
      "Enter a valid address as on passport";

// Error messages for postal code validation
  static const String postalCodeError = "Enter postal code as on passport";
  static const String invalidPostalCodeError =
      "Enter a valid postal code as on passport";

// Error messages for city validation
  static const String cityError = "Enter city as on passport";
  static const String invalidCityError =
      "Enter a valid city name, as on passport";

// Error messages for state validation
  static const String stateError = "Enter state as on passport";
  static const String invalidStateError = "Enter a valid state as on passport";
  static const String passportNumberLengthError =
      "Enter a valid passport number with 8 characters";

  // Error messages for passport fields validation
  static const String invalidIssueDateError =
      "Enter a valid passport issue date";
  static const String invalidExpiryDateError =
      "Enter a valid passport expiry date";
  static const String expiredPassportError =
      "Passport is expired - please upload a valid passport";
  static const String dobError = "Enter date of birth";
  static const String invalidDobError = "Enter a valid date of birth";
  static const String enterMrzLine1 = "Enter MRZ line 1";
  static const String enterMrzLine2 = "Enter MRZ line 2";
  static const String invalidMrzLine1 = "Enter a valid MRZ line 1";
  static const String invalidMrzLine2 = "Enter a valid MRZ line 2";
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
