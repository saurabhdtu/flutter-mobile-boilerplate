import 'package:flutter/material.dart';

List<Color> parseGradientColors(dynamic gradientColors) {
  if (gradientColors is List) {
    return gradientColors.map<Color>((colorString) {
      if (colorString is String && colorString.startsWith('#')) {
        return Color(int.parse(colorString.replaceFirst('#', '0xff')));
      } else {
        throw FormatException("Invalid color string: $colorString");
      }
    }).toList();
  } else {
    throw TypeError(); // Handle unexpected types
  }
}
