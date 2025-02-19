import 'package:design_module/resources/zinc_style_kernings.dart';
import 'package:flutter/material.dart';

class ZincTextStyle extends TextStyle {
  //usage : ZincTextStyle.displayExtraBold(); and also like this  .copyWith(color:Colors.red);

  //default font color
  static const Color _defaultColor = const Color(0xFF262626);

  //mention fonts here
  static const String _satoshiFont = "Satoshi";

  //mention font fetaures here
  static const List<FontFeature> _satoshiFontFeature = [
    FontFeature.enable("ss03")
  ];

  /// pre defined font styles
  const ZincTextStyle.displayExtraBold({color = _defaultColor})
      : super(
          fontSize: 48,
          color: color,
          fontWeight: FontWeight.w900,
          fontFamily: _satoshiFont,
          fontFeatures: _satoshiFontFeature,
          height: (60 / 48),
          letterSpacing: Kernings.extraCondensed,
        );

  const ZincTextStyle.heroExtraBold({color = _defaultColor})
      : super(
          fontSize: 42,
          color: color,
          fontWeight: FontWeight.w900,
          fontFamily: _satoshiFont,
          fontFeatures: _satoshiFontFeature,
          height: (56 / 42),
          letterSpacing: Kernings.extraCondensed,
        );

  const ZincTextStyle.hugeExtraBold({color = _defaultColor})
      : super(
          fontSize: 36,
          color: color,
          fontWeight: FontWeight.w900,
          fontFamily: _satoshiFont,
          fontFeatures: _satoshiFontFeature,
          height: (48 / 36),
          letterSpacing: Kernings.extraCondensed,
        );

  const ZincTextStyle.bigExtraBold({color = _defaultColor})
      : super(
          fontSize: 30,
          color: color,
          fontWeight: FontWeight.w900,
          fontFamily: _satoshiFont,
          fontFeatures: _satoshiFontFeature,
          height: (40 / 30),
          letterSpacing: Kernings.extraCondensed,
        );

  const ZincTextStyle.superLargeExtraBold({color = _defaultColor})
      : super(
          fontSize: 28,
          color: color,
          fontWeight: FontWeight.w900,
          fontFamily: _satoshiFont,
          fontFeatures: _satoshiFontFeature,
          height: (32 / 28),
          letterSpacing: Kernings.extraCondensed,
        );

  const ZincTextStyle.extraLargeExtraBold({color = _defaultColor})
      : super(
          fontSize: 24,
          color: color,
          fontWeight: FontWeight.w900,
          fontFamily: _satoshiFont,
          fontFeatures: _satoshiFontFeature,
          height: (32 / 24),
          letterSpacing: Kernings.condensed,
        );

  const ZincTextStyle.largeExtraBold({color = _defaultColor})
      : super(
          fontSize: 20,
          color: color,
          fontWeight: FontWeight.w900,
          fontFamily: _satoshiFont,
          fontFeatures: _satoshiFontFeature,
          height: (28 / 20),
          letterSpacing: Kernings.condensed,
        );

  const ZincTextStyle.moderateBold({color = _defaultColor})
      : super(
          fontSize: 18,
          color: color,
          fontWeight: FontWeight.w700,
          fontFamily: _satoshiFont,
          fontFeatures: _satoshiFontFeature,
          height: (24 / 18),
        );

  const ZincTextStyle.normalBold({color = _defaultColor})
      : super(
          fontSize: 16,
          color: color,
          fontWeight: FontWeight.w700,
          fontFamily: _satoshiFont,
          fontFeatures: _satoshiFontFeature,
          height: (24 / 16),
        );

  const ZincTextStyle.smallBold({color = _defaultColor})
      : super(
          fontSize: 14,
          color: color,
          fontWeight: FontWeight.w700,
          fontFamily: _satoshiFont,
          fontFeatures: _satoshiFontFeature,
          height: (20 / 14),
        );

  const ZincTextStyle.tinyBoldCaps({color = _defaultColor})
      : super(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w700,
          fontFamily: _satoshiFont,
          fontFeatures: _satoshiFontFeature,
          height: (16 / 12),
          letterSpacing: Kernings.wide,
        );

  const ZincTextStyle.microBoldCaps({color = _defaultColor})
      : super(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w700,
          fontFamily: _satoshiFont,
          fontFeatures: _satoshiFontFeature,
          height: (16 / 10),
          letterSpacing: Kernings.wide,
        );

  const ZincTextStyle.moderateSemiBold({color = _defaultColor})
      : super(
          fontSize: 18,
          color: color,
          fontWeight: FontWeight.w500,
          fontFamily: _satoshiFont,
          fontFeatures: _satoshiFontFeature,
          height: (24 / 16),
        );

  const ZincTextStyle.normalSemiBold({color = _defaultColor})
      : super(
          fontSize: 16,
          color: color,
          fontWeight: FontWeight.w500,
          fontFamily: _satoshiFont,
          fontFeatures: _satoshiFontFeature,
          height: (24 / 16),
        );

  const ZincTextStyle.smallSemiBold({color = _defaultColor})
      : super(
          fontSize: 14,
          color: color,
          fontWeight: FontWeight.w500,
          fontFamily: _satoshiFont,
          fontFeatures: _satoshiFontFeature,
          height: (20 / 14),
        );

  const ZincTextStyle.tinySemiBold({color = _defaultColor})
      : super(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w500,
          fontFamily: _satoshiFont,
          fontFeatures: _satoshiFontFeature,
          height: (16 / 12),
        );

  const ZincTextStyle.moderateRegular({color = _defaultColor})
      : super(
          fontSize: 18,
          color: color,
          fontWeight: FontWeight.w400,
          fontFamily: _satoshiFont,
          fontFeatures: _satoshiFontFeature,
          height: (24 / 18),
        );

  const ZincTextStyle.normalRegular({color = _defaultColor})
      : super(
          fontSize: 16,
          color: color,
          fontWeight: FontWeight.w400,
          fontFamily: _satoshiFont,
          fontFeatures: _satoshiFontFeature,
          height: (24 / 16),
        );

  const ZincTextStyle.smallRegular({color = _defaultColor})
      : super(
          fontSize: 14,
          color: color,
          fontWeight: FontWeight.w400,
          fontFamily: _satoshiFont,
          fontFeatures: _satoshiFontFeature,
          height: (20 / 14),
        );

  const ZincTextStyle.tinyRegular({color = _defaultColor})
      : super(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w400,
          fontFamily: _satoshiFont,
          fontFeatures: _satoshiFontFeature,
          height: (16 / 12),
        );

  const ZincTextStyle.superTinyRegular({color = _defaultColor, fontSize = 10.0})
      : super(
          fontSize: fontSize,
          color: color,
          fontWeight: FontWeight.w400,
          fontFamily: _satoshiFont,
          fontFeatures: _satoshiFontFeature,
          height: (16 / 12),
        );

  static const Map<int, Map<int, ZincTextStyle>> weightFontMappings = {
    900: {
      48: ZincTextStyle.displayExtraBold(),
      42: ZincTextStyle.heroExtraBold(),
      36: ZincTextStyle.hugeExtraBold(),
      30: ZincTextStyle.bigExtraBold(),
      28: ZincTextStyle.superLargeExtraBold(),
      24: ZincTextStyle.extraLargeExtraBold(),
      20: ZincTextStyle.largeExtraBold()
    },
    700: {
      18: ZincTextStyle.moderateBold(),
      16: ZincTextStyle.normalBold(),
      14: ZincTextStyle.smallBold(),
      12: ZincTextStyle.tinyBoldCaps(),
      10: ZincTextStyle.microBoldCaps()
    },
    500: {
      18: ZincTextStyle.moderateSemiBold(),
      16: ZincTextStyle.normalSemiBold(),
      14: ZincTextStyle.smallSemiBold(),
      12: ZincTextStyle.tinySemiBold(),
    },
    400: {
      18: ZincTextStyle.moderateRegular(),
      16: ZincTextStyle.normalRegular(),
      14: ZincTextStyle.smallRegular(),
      12: ZincTextStyle.tinyRegular(),
      10: ZincTextStyle.superTinyRegular()
    }
  };
}
