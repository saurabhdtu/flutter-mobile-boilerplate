import 'package:design_module/resources/zinc_style_sizing_primitives.dart';
import 'package:flutter/material.dart';

class ZincPadding {
  static EdgeInsets get fullSmall => EdgeInsets.all(TwosSizingPrimitive().m);
  static EdgeInsets get fullMedium => EdgeInsets.all(TwosSizingPrimitive().l);
  static EdgeInsets get fullLarge => EdgeInsets.all(TwosSizingPrimitive().l);

  static EdgeInsets get horizontalSmall =>
      EdgeInsets.symmetric(horizontal: TwosSizingPrimitive().xxl);

  static EdgeInsets get horizontalMedium =>
      EdgeInsets.symmetric(horizontal: TwosSizingPrimitive().xxl);

  static EdgeInsets get horizontalLarge =>
      EdgeInsets.symmetric(horizontal: TwosSizingPrimitive().xxxl);

  static EdgeInsets get verticalSmall =>
      EdgeInsets.symmetric(vertical: TwosSizingPrimitive().m);

  static EdgeInsets get verticalMedium =>
      EdgeInsets.symmetric(vertical: TwosSizingPrimitive().l);

  static EdgeInsets get verticalLarge =>
      EdgeInsets.symmetric(vertical: TwosSizingPrimitive().l);

  static EdgeInsets get hvSmall => EdgeInsets.symmetric(
      horizontal: TwosSizingPrimitive().xxl, vertical: TwosSizingPrimitive().m);

  static EdgeInsets get hvMedium => EdgeInsets.symmetric(
      horizontal: TwosSizingPrimitive().xxl, vertical: TwosSizingPrimitive().l);

  static EdgeInsets get hvLarge => EdgeInsets.symmetric(
      horizontal: TwosSizingPrimitive().xxxl,
      vertical: TwosSizingPrimitive().l);

  static EdgeInsets get hv24By16 => EdgeInsets.symmetric(
        horizontal: TwosSizingPrimitive().xxl,
        vertical: TwosSizingPrimitive().l,
      );

  static EdgeInsets get ltrbTextFieldParentContainer => EdgeInsets.fromLTRB(
        TwosSizingPrimitive().l,
        TwosSizingPrimitive().xxs,
        TwosSizingPrimitive().l,
        TwosSizingPrimitive().m,
      );

  static EdgeInsets get hv14 =>
      const EdgeInsets.symmetric(horizontal: 14, vertical: 14);

  static EdgeInsets get l8r2Margin => EdgeInsets.only(
      left: TwosSizingPrimitive().s, right: TwosSizingPrimitive().xxxs);

  static EdgeInsets get onlyLeftSmall =>
      EdgeInsets.only(left: TwosSizingPrimitive().s);

  static EdgeInsets get onlyTopSmall =>
      EdgeInsets.only(top: TwosSizingPrimitive().s);

  static EdgeInsets get onlyTop18 => const EdgeInsets.only(top: 18);
  static EdgeInsets get onlyTop7 => const EdgeInsets.only(top: 7);

  static EdgeInsets get allXxs =>
      EdgeInsets.only(left: TwosSizingPrimitive().xxs);
}
