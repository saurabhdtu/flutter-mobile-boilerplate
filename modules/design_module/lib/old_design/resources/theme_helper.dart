import 'package:design_module/old_design/resources/size_utils.dart';
import 'package:flutter/material.dart';

String _appTheme = "primary";
PrimaryColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

/// Helper class for managing themes and colors.
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class ThemeHelper {
  // A map of custom color themes supported by the app
  Map<String, PrimaryColors> _supportedCustomColor = {
    'primary': PrimaryColors()
  };

// A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'primary': ColorSchemes.primaryColorScheme
  };

  /// Changes the app theme to [_newTheme].
  void changeTheme(String _newTheme) {
    _appTheme = _newTheme;
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? PrimaryColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.primaryColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: 1,
        color: appTheme.indigo5001,
      ),
    );
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyLarge: TextStyle(
          color: colorScheme.onErrorContainer,
          fontSize: 16.fSize,
          fontFamily: 'Satoshi',
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: appTheme.gray900,
          fontSize: 14.fSize,
          fontFamily: 'Satoshi',
          fontWeight: FontWeight.w400,
        ),
        displayMedium: TextStyle(
          color: appTheme.black900,
          fontSize: 40.fSize,
          fontFamily: 'Satoshi',
          fontWeight: FontWeight.w500,
        ),
        headlineLarge: TextStyle(
          color: appTheme.black900,
          fontSize: 30.fSize,
          fontFamily: 'Satoshi',
          fontWeight: FontWeight.w900,
        ),
        headlineSmall: TextStyle(
          color: appTheme.gray900,
          fontSize: 24.fSize,
          fontFamily: 'Satoshi',
          fontWeight: FontWeight.w900,
        ),
        labelLarge: TextStyle(
          color: appTheme.blueGray600,
          fontSize: 12.fSize,
          fontFamily: 'Satoshi',
          fontWeight: FontWeight.w700,
        ),
        labelMedium: TextStyle(
          color: appTheme.black900,
          fontSize: 10.fSize,
          fontFamily: 'Satoshi',
          fontWeight: FontWeight.w700,
        ),
        labelSmall: TextStyle(
          color: colorScheme.onErrorContainer.withOpacity(1),
          fontSize: 8.fSize,
          fontFamily: 'Satoshi',
          fontWeight: FontWeight.w700,
        ),
        titleLarge: TextStyle(
          color: colorScheme.onErrorContainer.withOpacity(1),
          fontSize: 20.fSize,
          fontFamily: 'Satoshi',
          fontWeight: FontWeight.w900,
        ),
        titleMedium: TextStyle(
          color: appTheme.blueGray800,
          fontSize: 18.fSize,
          fontFamily: 'Satoshi',
          fontWeight: FontWeight.w700,
        ),
        titleSmall: TextStyle(
          color: appTheme.black900,
          fontSize: 14.fSize,
          fontFamily: 'Satoshi',
          fontWeight: FontWeight.w500,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static final primaryColorScheme = ColorScheme.light(
    primary: Color(0XFF061151),
    primaryContainer: Color(0XFFDB228A),
    secondaryContainer: Color(0X990F0F38),
    errorContainer: Color(0XFF17358B),
    onError: Color(0XFF14191F),
    onErrorContainer: Color(0X99FFFFFF),
    onPrimary: Color(0XFF8B92B3),
    onPrimaryContainer: Color(0XFF080832),
    onSecondaryContainer: Color(0XFF5E5EEA),
  );
}

/// Class containing custom colors for a primary theme.
class PrimaryColors {
  // Black
  Color get black900 => Color(0XFF000000);
// BlueGray
  Color get blueGray400 => Color(0XFF888888);
  Color get blueGray600 => Color(0XFF606683);
  Color get blueGray800 => Color(0XFF333648);
// DeepPurple
  Color get deepPurple100 => Color(0XFFDCCFFF);
  Color get deepPurple50 => Color(0XFFE6DDFF);
  Color get deepPurple800 => Color(0XFF443194);
  Color get deepPurpleA200 => Color(0XFF6C52E0);
// Gray
  Color get gray100 => Color(0XFFF1F3FE);
  Color get gray10001 => Color(0XFFF5F5F5);
  Color get gray200 => Color(0XFFEAEAEA);
  Color get gray5001 => Color(0XFFF7F8FF);
  Color get gray5002 => Color(0XFFF7F8FE);
  Color get gray800 => Color(0XFF4F4F4F);
  Color get gray900 => Color(0XFF1A1C26);
// Green
  Color get green400 => Color(0XFF54CE85);
  Color get green500 => Color(0XFF3BD153);
  Color get greenA200 => Color(0XFF48F597);
  Color get greenA400 => Color(0XFF0AD969);
  Color get greenA700 => Color(0XFF08B056);
  Color get green900 => Color(0XFF1E4308);
// Indigo
  Color get indigo50 => Color(0XFFDDE1F5);
  Color get indigo5001 => Color(0XFFE6E9F9);
  Color get indigoA700 => Color(0XFF3753F1);
// LightGreen
  Color get lightGreenA100 => Color(0XFFB6F88E);
  Color get lightGreen50 => Color(0XFFF0FFE7);
// Orange
  Color get orange300 => Color(0XFFFAB56B);
// Red
  Color get red700 => Color(0XFFBD3D44);
// White
  Color get whiteA700 => Color(0XFFFBFCFF);

  // Teal
  Color get teal50 => Color(0XFFE1FEEF);
  Color get teal800 => Color(0XFF047A3B);
}
