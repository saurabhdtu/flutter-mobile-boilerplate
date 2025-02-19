import 'package:design_module/old_design/resources/font_manager.dart';
import 'package:flutter/material.dart';

class TextHubotRegular extends Text {
  TextHubotRegular(String text,
      {super.key,
      double? fontSize = 12.0,
      TextAlign textAlign = TextAlign.start,
      Color color = Colors.black,
      int? maxLines,
      TextOverflow? overflow,
      double? height,
      TextDecoration? decoration,
      Color? decorationColor,
      fontFamily = FontConstants.fontFamilyHubot,
      FontWeight fontWeight = FontWeightManager.regular,
      FontStyle? fontStyle})
      : super(text,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
            style: TextStyle(
                fontSize: fontSize,
                color: color,
                height: height,
                decoration: decoration,
                decorationColor: decorationColor,
                fontWeight: fontWeight,
                fontStyle: fontStyle));
}

class HubotRegularTextStyle extends TextStyle {
  const HubotRegularTextStyle(
      {fontSize = 12.0,
      color,
      height,
      decoration,
      decorationColor,
      fontWeight,
      fontStyle})
      : super(
            fontSize: 12.0,
            color: color,
            height: height,
            decoration: decoration,
            fontFamily: FontConstants.fontFamilyHubot,
            decorationColor: decorationColor,
            fontWeight: FontWeightManager.regular,
            fontStyle: fontStyle);
}

class TextHubotSemiBold extends Text {
  TextHubotSemiBold(String text,
      {super.key,
      double? fontSize = 12.0,
      TextAlign textAlign = TextAlign.start,
      Color color = Colors.black,
      int? maxLines,
      TextOverflow? overflow,
      double? height,
      TextDecoration? decoration,
      Color? decorationColor,
      fontFamily = FontConstants.fontFamilyHubot,
      FontWeight fontWeight = FontWeightManager.semiBold,
      FontStyle? fontStyle})
      : super(text,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
            style: TextStyle(
                fontSize: fontSize,
                color: color,
                height: height,
                decoration: decoration,
                decorationColor: decorationColor,
                fontWeight: fontWeight,
                fontStyle: fontStyle));
}

class TextHubotBold extends Text {
  TextHubotBold(String text,
      {super.key,
      double? fontSize = 12.0,
      TextAlign textAlign = TextAlign.start,
      Color color = Colors.black,
      int? maxLines,
      TextOverflow? overflow,
      double? height,
      TextDecoration? decoration,
      Color? decorationColor,
      fontFamily = FontConstants.fontFamilyHubot,
      FontWeight fontWeight = FontWeightManager.bold,
      FontStyle? fontStyle})
      : super(text,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
            style: TextStyle(
                fontSize: fontSize,
                color: color,
                height: height,
                decoration: decoration,
                decorationColor: decorationColor,
                fontWeight: fontWeight,
                fontStyle: fontStyle));
}

class TextHubotBlack extends Text {
  TextHubotBlack(String text,
      {super.key,
      double? fontSize = 12.0,
      TextAlign textAlign = TextAlign.start,
      Color color = Colors.black,
      int? maxLines,
      TextOverflow? overflow,
      double? height,
      TextDecoration? decoration,
      Color? decorationColor,
      fontFamily = FontConstants.fontFamilyHubot,
      FontWeight fontWeight = FontWeightManager.extraBold,
      FontStyle? fontStyle})
      : super(text,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
            style: TextStyle(
                fontSize: fontSize,
                color: color,
                height: height,
                decoration: decoration,
                decorationColor: decorationColor,
                fontWeight: fontWeight,
                fontStyle: fontStyle));
}

class HubotBlackTextStyle extends TextStyle {
   HubotBlackTextStyle(
      {fontSize,
      color,
      height,
      decoration,
      decorationColor,
      fontWeight,
      fontStyle})
      : super(
            fontSize: fontSize??12.0,
            color: color,
            height: height,
            decoration: decoration,
            fontFamily: FontConstants.fontFamilyHubot,
            decorationColor: decorationColor,
            fontWeight: FontWeightManager.extraBold,
            fontStyle: fontStyle);
}

class TextSatoshiRegular extends Text {
  TextSatoshiRegular(String text,
      {super.key,
      double? fontSize = 12.0,
      TextAlign textAlign = TextAlign.start,
      Color color = Colors.black,
      int? maxLines,
      TextOverflow? overflow,
      double? height,
      TextDecoration? decoration,
      Color? decorationColor,
      fontFamily = FontConstants.fontFamilySatoshi,
      FontWeight fontWeight = FontWeightManager.regular,
      FontStyle? fontStyle})
      : super(text,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
            style: TextStyle(
                fontSize: fontSize,
                color: color,
                height: height,
                decoration: decoration,
                decorationColor: decorationColor,
                fontWeight: fontWeight,
                fontStyle: fontStyle));
}

class TextSatoshiMedium extends Text {
  TextSatoshiMedium(String text,
      {super.key,
      double? fontSize = 12.0,
      TextAlign textAlign = TextAlign.start,
      Color color = Colors.black,
      int? maxLines,
      TextOverflow? overflow,
      double? height,
      TextDecoration? decoration,
      Color? decorationColor,
      fontFamily = FontConstants.fontFamilySatoshi,
      FontWeight fontWeight = FontWeightManager.medium,
      FontStyle? fontStyle})
      : super(text,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
            style: TextStyle(
                fontSize: fontSize,
                color: color,
                height: height,
                decoration: decoration,
                decorationColor: decorationColor,
                fontWeight: fontWeight,
                fontStyle: fontStyle));
}

class TextSatoshiBold extends Text {
  TextSatoshiBold(String text,
      {super.key,
      double? fontSize = 12.0,
      TextAlign textAlign = TextAlign.start,
      Color color = Colors.black,
      int? maxLines,
      TextOverflow? overflow,
      double? height,
      TextDecoration? decoration,
      Color? decorationColor,
      fontFamily = FontConstants.fontFamilySatoshi,
      FontWeight fontWeight = FontWeightManager.bold,
      FontStyle? fontStyle})
      : super(text,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
            style: TextStyle(
                fontSize: fontSize,
                color: color,
                height: height,
                decoration: decoration,
                decorationColor: decorationColor,
                fontWeight: fontWeight,
                fontStyle: fontStyle));
}

class TextSatoshiBlack extends Text {
  TextSatoshiBlack(String text,
      {super.key,
      double? fontSize = 12.0,
      TextAlign textAlign = TextAlign.start,
      Color color = Colors.black,
      int? maxLines,
      TextOverflow? overflow,
      double? height,
      TextDecoration? decoration,
      Color? decorationColor,
      fontFamily = FontConstants.fontFamilySatoshi,
      FontWeight fontWeight = FontWeightManager.extraBold,
      FontStyle? fontStyle})
      : super(text,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
            style: TextStyle(
                fontSize: fontSize,
                color: color,
                height: height,
                decoration: decoration,
                decorationColor: decorationColor,
                fontWeight: fontWeight,
                fontStyle: fontStyle));
}

class SatoshiBoldTextStyle extends TextStyle {
  const SatoshiBoldTextStyle(
      {fontSize = 12.0,
      color,
      height,
      decoration,
      decorationColor,
      fontWeight,
      fontStyle})
      : super(
            fontSize: fontSize,
            color: color,
            height: height,
            decoration: decoration,
            fontFamily: FontConstants.fontFamilySatoshi,
            decorationColor: decorationColor,
            fontWeight: FontWeightManager.bold,
            fontStyle: fontStyle);
}
