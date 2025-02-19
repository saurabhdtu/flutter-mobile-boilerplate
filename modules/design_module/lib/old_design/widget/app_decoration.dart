import 'dart:math';

import 'package:flutter/material.dart';
import 'package:design_module/old_design/resources/color_manager.dart';

import '../resources/theme_helper.dart';

class AppDecoration {

  static List stickyColors = [
    const Color(0xffB85252),
    const Color(0XFFDDE1F5),
    const Color(0xffF4ABC4),
    const Color(0xff346751),
    const Color(0xffFFC947),
    const Color(0xff3282B8),
    const Color(0XFF443194),
    const Color(0XFF443194),
    const Color(0XFF3BD153),
  ];

  // Fill decorations
  static BoxDecoration get fillDeepPurple => BoxDecoration(
        color: ColorManager.deepPurple100,
      );
  static BoxDecoration get fillDeeppurple800 => BoxDecoration(
        color: ColorManager.deepPurple800,
      );
  static BoxDecoration get fillGray => BoxDecoration(
        color: ColorManager.gray200,
      );
  static BoxDecoration get fillLightGreen => BoxDecoration(
    color: appTheme.lightGreen50,
  );
  static BoxDecoration get fillIndigoA700 => BoxDecoration(
    color: appTheme.indigoA700,
  );
  static BoxDecoration get fillGray5001 => BoxDecoration(
        color: ColorManager.gray5001,
      );
  static BoxDecoration get fillGreyBgCard => BoxDecoration(
    color: ColorManager.lightBlueBg,
  );
  static BoxDecoration get fillGray5002 => BoxDecoration(
        color: ColorManager.gray5002,
      );
  static BoxDecoration get fillGreen => BoxDecoration(
        color: ColorManager.green400,
      );
  static BoxDecoration get fillRandomColor => BoxDecoration(
    color: stickyColors[Random().nextInt(9)],
  );
  static BoxDecoration get fillLightGreenA => BoxDecoration(
        color: ColorManager.lightGreenA100,
      );
  static BoxDecoration get fillRed => BoxDecoration(
    color: ColorManager.red700,
  );
  static BoxDecoration get fillOnErrorContainer => BoxDecoration(
        color: ColorManager.white.withOpacity(0.09),
      );
  static BoxDecoration get fillOnErrorContainer1 => BoxDecoration(
        color: ColorManager.white.withOpacity(0.39),
      );
  static BoxDecoration get fillOnSecondaryContainer => BoxDecoration(
        color: ColorManager.white,
      );
  static BoxDecoration get fillOrange => BoxDecoration(
        color: ColorManager.orange300,
      );
  // static BoxDecoration get fillPrimaryContainer => BoxDecoration(
  //       color: theme.colorScheme.primaryContainer,
  //     );
  static BoxDecoration get fillWhiteA => BoxDecoration(
        color: ColorManager.whiteA700,
      );
// Gradient decorations
  static BoxDecoration get gradientGrayToOnErrorContainer => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.5, 0),
          end: Alignment(0.5, 1),
          colors: [
            ColorManager.gray10001,
            ColorManager.white.withOpacity(1)
          ],
        ),
      );

  static BoxDecoration get gradientGreenToOnErrorContainer => BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment(0.5, 0),
      end: Alignment(0.5, 1),
      colors: [
        ColorManager.green400,
        ColorManager.white.withOpacity(1)
      ],
    ),
  );
// Outline decorations
  static BoxDecoration get outline => BoxDecoration();
  static BoxDecoration get outlineIndigo => BoxDecoration(
        border: Border.all(
          color: ColorManager.indigo50,
          width: 1,
        ),
      );
  static BoxDecoration get outlineIndigo50 => BoxDecoration();
  static BoxDecoration get outlineOnErrorContainer => BoxDecoration(
    border: Border.all(
      color: ColorManager.grey,
      width: 1,
    ),
  );

  static BoxDecoration get gradientOnErrorContainerToOnErrorContainer =>
      BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.5, 0),
          end: Alignment(0.5, 0.37),
          colors: [
            theme.colorScheme.onErrorContainer.withOpacity(0),
            theme.colorScheme.onErrorContainer
          ],
        ),
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder12 => BorderRadius.circular(
        12,
      );
  static BorderRadius get roundedBorder15 => BorderRadius.circular(
    15,
  );
  static BorderRadius get circleBorder20 => BorderRadius.circular(
        20,
      );
  static BorderRadius get circleBorder24 => BorderRadius.circular(
        24,
      );
  static BorderRadius get circleBorder28 => BorderRadius.circular(
        28,
      );
  static BorderRadius get circleBorder9 => BorderRadius.circular(
        9,
      );
// Rounded borders
  static BorderRadius get roundedBorder16 => BorderRadius.circular(
        16,
      );
  static BorderRadius get roundedBorder98 => BorderRadius.circular(
        98,
      );
}
