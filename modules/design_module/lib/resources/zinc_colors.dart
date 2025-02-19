import 'package:flutter/material.dart';

abstract class ZincColors {
  //Main colors for color palette
  static const int _primary = 0xff21D060;
  static const int _secondary = 0xff2B7FA6;
  static const int _error = 0xffDE6844;
  static const int _warning = 0xffF0D019;
  static const int _success = 0xff81B918;
  static const int _greyscale = 0xffD9D9D9;

  //Color palettes

  static const MaterialColor zincGreen = const MaterialColor(
    _primary,
    <int, Color>{
      50: Color(0xFFE3FFED),
      100: Color(0xFFCBFFDE),
      200: Color(0xFF7FFFAD),
      300: Color(0xFF6BFFA0),
      400: Color(0xFF2EF275),
      500: Color(_primary),
      600: Color(0xFF09B447),
      700: Color(0xFF078935),
      800: Color(0xFF045B23),
      900: Color(0xFF032C12),
      950: Color(0xff011508)
    },
  );

  static const MaterialColor zincChrome = const MaterialColor(
    _secondary,
    <int, Color>{
      50: Color(0xFFE5F4FA),
      100: Color(0xFFD5E4EB),
      200: Color(0xFFA7CBDC),
      300: Color(0xFF76B4D0),
      400: Color(0xFF469FC8),
      500: Color(_secondary),
      600: Color(0xFF1B5B79),
      700: Color(0xFF0D374A),
      800: Color(0xFF11394B),
      900: Color(0xFF143B4D),
      950: Color(0xFF173D4F),
    },
  );

  static const MaterialColor zincImperialRed = const MaterialColor(
    _error,
    <int, Color>{
      50: Color(0xFFFCF1EE),
      100: Color(0xFFF8DFD8),
      200: Color(0xFFF2C3B5),
      300: Color(0xFFEBA48E),
      400: Color(0xFFE5866A),
      500: Color(_error),
      600: Color(0xFFD54E25),
      700: Color(0xFFB2411F),
      800: Color(0xFF8F3519),
      900: Color(0xFF682612),
      950: Color(0xFF57200F),
    },
  );

  static const MaterialColor zincSelectiveYellow = const MaterialColor(
    _warning,
    <int, Color>{
      50: Color(0xFFFDFAE7),
      100: Color(0xFFFCF5CF),
      200: Color(0xFFF8EA9B),
      300: Color(0xFFF5E06B),
      400: Color(0xFFF2D53A),
      500: Color(_warning),
      600: Color(0xFFD7B90E),
      700: Color(0xFFB1980C),
      800: Color(0xFF907B09),
      900: Color(0xFF6E5F07),
      950: Color(0xFF605206),
    },
  );

  static const MaterialColor zincOliveGreen = const MaterialColor(
    _success,
    <int, Color>{
      50: Color(0xFFF1FBDF),
      100: Color(0xFFE6F7C4),
      200: Color(0xFFCAEF85),
      300: Color(0xFFB1E84A),
      400: Color(0xFF94D31B),
      500: Color(_success),
      600: Color(0xFF6E9E14),
      700: Color(0xFF5B8311),
      800: Color(0xFF4B6D0E),
      900: Color(0xFF39510A),
      950: Color(0xFF2F4409),
    },
  );

  static const MaterialColor zincGrey = const MaterialColor(
    _greyscale,
    <int, Color>{
      50: Color(0xFFFEFEFE),
      100: Color(0xFFF8F8F8),
      150: Color(0xFFF8F7FC),
      200: Color(0xFFF0F0F0),
      300: Color(0xFFE8E8E8),
      400: Color(0xFFE0E0E0),
      500: Color(_greyscale),
      600: Color(0xFFC4C4C4),
      700: Color(0xFFA9A9A9),
      800: Color(0xFF828282),
      900: Color(0xFF434343),
      950: Color(0xFF262626),
    },
  );

  //Neutral Colors
  static const Color neutralRichBlack = Color.fromRGBO(31, 31, 31, 1);
  static const Color neutralTransparentBlack = Color.fromRGBO(31, 31, 31, 0.72);
  static const Color neutralWhite = Color(0xFFFFFFFF);
  static const Color black50 = Colors.black54;
  static const Color black90 = Colors.black87;
  static const Color grey = Color(0xFF9E9E9E); // Equivalent to Colors.grey
  static const Color black = Color(0xFF000000); // Equivalent to Colors.black
  static const Color red = Color(0xFFF44336); // Equivalent to Colors.red
  static const Color gray5002 = Color(0xFFF7F8FE);
  static const Color appUpdate = const Color(0XFF777777);
  static const Color appUpdateIconBG = const Color(0XFF13B744);
}
