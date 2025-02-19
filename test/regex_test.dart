import 'package:flutter_test/flutter_test.dart';
import 'package:zinc/app/constant.dart';

extension _matcherExtension on String{
  bool hasMatch(String regex){
    return RegExp(regex).hasMatch(this);
  }
}
void main() {
  test("test_otp_regex", () {
    String sms = "683900 is the OTP for your login to the Zinc app. OTP is valid for next 5 minutes. Please do not share with anyone. Qa8sbfZn6wN";
    final match = RegExp(Regex.otpRegex).firstMatch(sms);
    final otp = sms.substring(match!.start, match.end);
    expect(otp, "683900");
  });
  group('Regex Tests', () {
    test('Email Regex', () {
      expect("test@example.com".hasMatch(Regex.emailRegex), isTrue);
      expect("test.test@example.co.uk".hasMatch(Regex.emailRegex), isTrue);
      expect("test+test@example.com".hasMatch(Regex.emailRegex), isTrue);
      expect("test@123.456.789.0".hasMatch(Regex.emailRegex), isFalse);
      expect("\"test.test\"@example.com".hasMatch(Regex.emailRegex), isTrue);
      expect("invalid_email".hasMatch(Regex.emailRegex), isFalse);
      expect("test@example".hasMatch(Regex.emailRegex), isFalse);
      expect("test@.com".hasMatch(Regex.emailRegex), isFalse);
    });

    test('Mobile Regex', () {
      expect("9876543210".hasMatch(Regex.mobileRegex), isTrue);
      expect("6123456789".hasMatch(Regex.mobileRegex), isTrue);
      expect("1234567890".hasMatch(Regex.mobileRegex), isFalse);
      expect("987654321".hasMatch(Regex.mobileRegex), isFalse);
      expect("98765432100".hasMatch(Regex.mobileRegex), isFalse);
      expect("ABCDEFGHIJ".hasMatch(Regex.mobileRegex), isFalse);
    });

    test('Swift Regex', () {
      expect("DEUTDEFF500".hasMatch(Regex.swiftRegex), isTrue);
      expect("ABCDEFGH12".hasMatch(Regex.swiftRegex), isFalse);
      expect("ABCDEFGH1234".hasMatch(Regex.swiftRegex), isFalse);
      expect("abcdefgh12".hasMatch(Regex.swiftRegex), isFalse);
      expect("DEUTDEF".hasMatch(Regex.swiftRegex), isFalse);
    });

    test('OTP Regex', () {
      expect("123456".hasMatch(Regex.otpRegex), isTrue);
      expect("000000".hasMatch(Regex.otpRegex), isTrue);
      expect("12345".hasMatch(Regex.otpRegex), isFalse);
      expect("1234567".hasMatch(Regex.otpRegex), isTrue);
      expect("ABCDEF".hasMatch(Regex.otpRegex), isFalse);
    });

    test('Name Regex', () {
      expect("John Doe".hasMatch(Regex.nameRegex), isTrue);
      expect("Jane Smith".hasMatch(Regex.nameRegex), isTrue);
      expect("John".hasMatch(Regex.nameRegex), isTrue);
      expect("John123".hasMatch(Regex.nameRegex), isFalse);
      expect("John Doe!".hasMatch(Regex.nameRegex), isFalse);
    });

    test('Passport Number Regex', () {
      expect("AB123456".hasMatch(Regex.passportNumberRegex), isTrue);
      expect("123456789".hasMatch(Regex.passportNumberRegex), isFalse);
      expect("AB123456789".hasMatch(Regex.passportNumberRegex), isFalse);
      expect("AB 1234567".hasMatch(Regex.passportNumberRegex), isFalse);
    });

    test('Date Regex', () {
      expect("01/01/2023".hasMatch(Regex.dateRegex), isTrue);
      expect("31/12/2024".hasMatch(Regex.dateRegex), isTrue);
      expect("1/1/2023".hasMatch(Regex.dateRegex), isFalse);
      expect("01/1/2023".hasMatch(Regex.dateRegex), isFalse);
      expect("01/01/202".hasMatch(Regex.dateRegex), isFalse);
      expect("32/01/2023".hasMatch(Regex.dateRegex), isFalse);
      expect("01/13/2023".hasMatch(Regex.dateRegex), isFalse);
    });

    test('Postal Code Regex', () {
      expect("123456".hasMatch(Regex.postalCodeRegex), isTrue);
      expect("000000".hasMatch(Regex.postalCodeRegex), isTrue);
      expect("12345".hasMatch(Regex.postalCodeRegex), isFalse);
      expect("1234567".hasMatch(Regex.postalCodeRegex), isFalse);
      expect("ABCDEF".hasMatch(Regex.postalCodeRegex), isFalse);
    });

    test('Address Regex', () {
      expect("123 Main St".hasMatch(Regex.addressRegex), isTrue);
      expect("Apt. 4B, 123 Main St.".hasMatch(Regex.addressRegex), isTrue);
      expect("123-45 Main St".hasMatch(Regex.addressRegex), isTrue);
      expect("!@#\$%^&*()_+".hasMatch(Regex.addressRegex), isFalse);
    });


    test('MRZ Line 1 Regex', () {
      expect("P<UTOTEST<<TEST<TEST<<<<<<<<<<<<<<<<<<<<<".hasMatch(Regex.mrzLine1Regex), isTrue);
      expect("P<MEX<<TESTER<CODE<<<<<<<<<<<<<<<<<<<<<<<".hasMatch(Regex.mrzLine1Regex), isTrue);
      expect("P<IND<<INDIA<<<<<<<<<<<<<<<<<<<<<<<<<<".hasMatch(Regex.mrzLine1Regex), isTrue);
      expect("P<USA<<UNITED STATES<<<<<<<<<<<<<<<".hasMatch(Regex.mrzLine1Regex), isFalse);
      expect("P<CAN<<CANADA<<<<<<<<<<<<<<<<<<<<<<<<".hasMatch(Regex.mrzLine1Regex), isTrue);
      expect("P<123<<456<<<<<<<<<<<<<<<<<<<<<<<<<<<".hasMatch(Regex.mrzLine1Regex), isFalse);
    });

    test('MRZ Line 2 Regex', () {
      expect("Y5886215<9IND9311273M33061942075477906723<74".hasMatch(Regex.mrzLine2Regex), isTrue);
      expect("A123456789GBR7601019F1204159GBR<<<<<<<<<<<10".hasMatch(Regex.mrzLine2Regex), isTrue);
      expect("InvalidMRZLine2".hasMatch(Regex.mrzLine2Regex), isFalse);
    });
  });
}