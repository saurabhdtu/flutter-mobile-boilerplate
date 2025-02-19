import 'package:design_module/old_design/resources/size_utils.dart';
import 'package:design_module/old_design/resources/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:design_module/old_design/resources/color_manager.dart';

extension on TextStyle {
  TextStyle get satoshi {
    return copyWith(
      fontFamily: 'Satoshi',
    );
  }
}

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.
@deprecated
class CustomTextStyles {
  // Display text style
  static get displayMediumOnErrorContainer =>
      theme.textTheme.displayMedium!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontSize: 43.fSize,
        fontWeight: FontWeight.w900,
      );
  static get titleLargeGreen900 => theme.textTheme.titleLarge!.copyWith(
    color: appTheme.green900,
    fontWeight: FontWeight.w900,
  );
  static get titleLargeOnPrimaryContainer =>
      theme.textTheme.titleLarge!.copyWith(
        color: ColorManager.white,
      );
  static get titleSmallOnPrimary => theme.textTheme.titleSmall!.copyWith(
    color: ColorManager.lightGreen,
  );
  static get titleLargeOnErrorContainer => theme.textTheme.titleLarge!.copyWith(
    color: theme.colorScheme.onErrorContainer,
  );
  static get bodyMediumOnPrimary => theme.textTheme.bodyMedium!.copyWith(
    color: theme.colorScheme.onPrimary,
  );
  static get titleMediumErrorContainerMedium =>
      theme.textTheme.titleMedium!.copyWith(
        color:  appTheme.black900,
        fontSize: 16.fSize,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumErrorContainer => theme.textTheme.titleMedium!.copyWith(
    color:  appTheme.black900,
    fontSize: 18.fSize,
  );
  static get titleSmallPrimaryContainer => theme.textTheme.titleSmall!.copyWith(
    color: theme.colorScheme.primaryContainer,
    fontWeight: FontWeight.w700,
  );
// Headline text style
  static get titleLargeErrorContainer => theme.textTheme.titleLarge!.copyWith(
    color:  appTheme.black900,
    fontWeight: FontWeight.w900,
  );
  static get headlineLarge32 => theme.textTheme.headlineLarge!.copyWith(
        fontSize: 32.fSize,
      );
  static get headlineSmallOnErrorContainer =>
      theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontWeight: FontWeight.w700,
      );
  static get headlineSmallOnPrimaryContainer =>
      theme.textTheme.headlineSmall!.copyWith(
        color: ColorManager.white,
      );
// Label text style
  static get labelLarge13 => theme.textTheme.labelLarge!.copyWith(
        fontSize: 13.fSize,
      );
  static get titleMediumOnSecondaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
        fontSize: 18.fSize,
      );

  static get titleMediumOnColor078935Container =>
      theme.textTheme.titleMedium!.copyWith(
        color: ColorManager.color078935,
        fontSize: 18.fSize,
      );
  static get labelLargeBlack900 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.black900,
      );
  static get labelLargeBlack900Medium => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w500,
      );
  static get titleSmallOnSecondaryContainer =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900,
      );
  static get titleMediumBluegray600Medium =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray600,
        fontWeight: FontWeight.w500,
      );
  static get headlineSmallOnSecondaryContainer =>
      theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.black900,
      );
  static get labelMediumBlack900 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.black900.withOpacity(0.49),
        fontWeight: FontWeight.w500,
      );
  static get labelMediumBluegray600 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.blueGray600,
      );
  static get labelMediumIndigoA700 => theme.textTheme.labelMedium!.copyWith(
        color: ColorManager.color357794,
      );
// Satoshi text style
  static get satoshiOnErrorContainer => TextStyle(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontSize: 6.fSize,
        fontWeight: FontWeight.w700,
      ).satoshi;
  static get satoshiOnErrorContainerBold => TextStyle(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontSize: 6.fSize,
        fontWeight: FontWeight.w700,
      ).satoshi;
// Title text style
  static get titleLargeBlack900 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w500,
      );
  static get titleLargeDisabled => theme.textTheme.titleLarge!.copyWith(
    color: appTheme.black900.withOpacity(0.30),
    fontWeight: FontWeight.w500,
  );
  static get titleLargeBluegray800 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black900,
      );
  static get titleMedium16 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 16.fSize,
      );
  static get titleMediumBluegray600 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray600,
        fontSize: 16.fSize,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumGray900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray900,
        fontSize: 16.fSize,
      );
  static get titleMediumOnBlack => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
        fontSize: 16.fSize,
      );
  static get titleMediumOnErrorContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontSize: 17.fSize,
      );
  static get titleMediumOnErrorContainer16 =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontSize: 16.fSize,
      );
  static get titleMediumOnPrimary => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontSize: 16.fSize,
      );
  static get titleMediumOnWhite => theme.textTheme.titleMedium!.copyWith(
    color: appTheme.whiteA700,
    fontSize: 16.fSize,
  );
  static get titleMediumSecondaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.secondaryContainer,
        fontSize: 16.fSize,
        fontWeight: FontWeight.w500,
      );
  static get titleSmallBlack900 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900.withOpacity(0.7),
      );
  static get titleSmallBluegray600 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray600,
      );
  static get titleSmallBluegray600Bold => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray600,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallBluegray800 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray800,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallGray900 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray900,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallGray900_1 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray900,
      );
  static get titleSmallPrimary => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallIndigoA700 => theme.textTheme.titleSmall!.copyWith(
    color: appTheme.indigoA700,
  );
  static get bodyMediumGray900 => theme.textTheme.bodyMedium!.copyWith(
    color: appTheme.gray900,
  );
  static get titleSmallGray900Bold_1 => theme.textTheme.titleSmall!.copyWith(
    color: appTheme.gray900,
    fontWeight: FontWeight.w700,
  );
  static get titleSmallGreenA700 => theme.textTheme.titleSmall!.copyWith(
    color: appTheme.greenA700,
    fontWeight: FontWeight.w700,
  );
}
