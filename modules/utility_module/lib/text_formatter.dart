import 'package:flutter/services.dart';

class TextInputFormatterWithRegex extends TextInputFormatter {
  final RegExp regex;

  TextInputFormatterWithRegex(String regex) : regex = RegExp(regex);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (!regex.hasMatch(newValue.text))
      return oldValue;
    else
      return newValue;
  }
}
