import 'package:intl/intl.dart';
import 'package:utility_module/extensions/string_extensions.dart';
import 'package:utility_module/constants/strings.dart';


abstract class FieldValidators {
  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return UtilityStrings.firstNameError;
    }
    final nameRegExp = RegExp(Regex.nameRegex);
    if (!nameRegExp.hasMatch(value)) {
      return UtilityStrings.firstNameError;
    }
    return null;
  }

  static String? passportNumberValidator(final String? value) {
    if (value == null || value.isEmpty) {
      return UtilityStrings.enterPassport;
    }
    final passport = RegExp(Regex.passportNumberRegex);
    if (!passport.hasMatch(value!)) return UtilityStrings.passportNumberError;
    if (value.length != 8) {
      return UtilityStrings.passportNumberLengthError;
    }
    return null;
  }

  static String? issueDateValidator(String? value) {
    if (value == null || value.isEmpty) {
      return UtilityStrings.issueDateError;
    }
    final dateRegExp = RegExp(Regex.dateRegex);
    if (!dateRegExp.hasMatch(value)) {
      return UtilityStrings.invalidIssueDateError;
    }
    // Validate that the issue date is not in the future
    DateTime? issueDate = _parseDate(value);
    if (issueDate == null || issueDate.isAfter(DateTime.now())) {
      return UtilityStrings.invalidIssueDateError;
    }
    return null;
  }

  static String? expiryDateValidator(String? value) {
    if (value == null || value.isEmpty) {
      return UtilityStrings.expiryDateError;
    }
    final dateRegExp =
        RegExp(Regex.dateRegex); // Assuming date format like DD/MM/YYYY
    if (!dateRegExp.hasMatch(value)) {
      return UtilityStrings.invalidExpiryDateError;
    }
    // Validate that the expiry date is in the future
    DateTime? expiryDate = _parseDate(value);
    if (expiryDate == null || expiryDate.isBefore(DateTime.now())) {
      return UtilityStrings.expiredPassportError;
    }
    return null;
  }

  static String? dobValidator(String? value) {
    if (value == null || value.isEmpty) {
      return UtilityStrings.dobError;
    }
    final dateRegExp =
        RegExp(Regex.dateRegex); // Assuming date format like DD/MM/YYYY
    if (!dateRegExp.hasMatch(value)) {
      return UtilityStrings.invalidDobError;
    }
    // Validate that the DOB is in the past
    DateTime? dob = _parseDate(value);
    if (dob == null || dob.isAfter(DateTime.now())) {
      return UtilityStrings.invalidDobError;
    }
    return null;
  }

  static String? mrzLine1Validator(String? value) {
    if (value == null || value.isEmpty) {
      return UtilityStrings.enterMrzLine1;
    }
    if (value.length != 44) return UtilityStrings.invalidMrzLine1;
    final mrz1Regex = RegExp(Regex.mrzLine1Regex);
    if (!mrz1Regex.hasMatch(value)) {
      return UtilityStrings.invalidMrzLine1;
    }
    return null;
  }

  static String? mrzLine2Validator(String? value) {
    if (value == null || value.isEmpty) {
      return UtilityStrings.enterMrzLine2;
    }
    if (value.length != 44) return UtilityStrings.invalidMrzLine2;
    final mrz2Regex = RegExp(Regex.mrzLine2Regex);
    if (!mrz2Regex.hasMatch(value)) {
      return UtilityStrings.invalidMrzLine2;
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value.isEmptyOrNull()) return UtilityStrings.enterEmail;
    if (!RegExp(Regex.emailRegex).hasMatch(value!)) {
      return UtilityStrings.enterValidEmail;
    }
    return null;
  }

  static DateTime? _parseDate(String date) {
    try {
      return DateFormat('dd/MM/yyyy').parse(date); // Assumes DD/MM/YYYY format
    } catch (e) {
      return null;
    }
  }

  static String? addressValidator(String? value) {
    if (value == null || value.isEmpty) {
      return UtilityStrings.addressError;
    }
    if (value.length < 2) {
      return UtilityStrings.invalidAddressError;
    }
    return null;
  }

  static String? postalCodeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return UtilityStrings.postalCodeError;
    }
    final postalRegExp = RegExp(Regex.postalCodeRegex);
    if (!postalRegExp.hasMatch(value)) {
      return UtilityStrings.invalidPostalCodeError;
    }
    return null;
  }

  static String? cityValidator(String? value) {
    if (value == null || value.isEmpty) {
      return UtilityStrings.cityError;
    }
    if (value.length < 2) {
      return UtilityStrings.invalidCityError;
    }
    return null;
  }

  static String? stateValidator(String? value) {
    if (value == null || value.isEmpty) {
      return UtilityStrings.stateError;
    }
    if (value.length < 2) {
      return UtilityStrings.invalidStateError;
    }
    return null;
  }
}
