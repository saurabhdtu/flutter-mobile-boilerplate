import 'package:flutter/material.dart';

abstract class ZincBgDecoration extends BoxDecoration {
  static BoxDecoration decorate(
          {double borderRad = 0,
          Color? borderColor,
          Color? backgroundColor,
          ImageProvider? backgroundImage,
            Gradient? gradient,
          BoxFit bgFit = BoxFit.fill}) =>
      BoxDecoration(
          color: backgroundColor,
          gradient: gradient,
          image: backgroundImage != null
              ? DecorationImage(image: backgroundImage, fit: bgFit)
              : null,
          borderRadius: BorderRadius.circular(borderRad),
          border:
              Border.all(color: borderColor ?? Colors.transparent, width: 1.0));
}
