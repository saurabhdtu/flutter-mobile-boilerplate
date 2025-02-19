import 'package:design_module/resources/zinc_style_border_radius.dart';
import 'package:design_module/resources/zinc_style_colors.dart';
import 'package:design_module/resources/zinc_style_padding.dart';
import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:design_module/widget/zinc_button.dart';
import 'package:flutter/material.dart';

class SecondaryZincButton extends ZincButton {
  @override
  final Widget? leftIcon;
  @override
  final String? title;
  @override
  final Widget? rightIcon;
  @override
  final Function()? onTap;
  @override
  final double? height;
  @override
  final double? width;
  @override
  final TextStyle? titleStyle;

  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;
  final Color? bgColor;

  const SecondaryZincButton({
    Key? key,
    this.leftIcon,
    this.title,
    this.rightIcon,
    this.onTap,
    this.height,
    this.width,
    this.padding,
    this.margin,
    this.borderRadius,
    this.bgColor,
    this.titleStyle,
  }) : super(
          key: key,
          leftIcon: leftIcon,
          title: title,
          rightIcon: rightIcon,
          onTap: onTap,
          titleStyle: titleStyle,
        );

  SecondaryZincButton copyWith({
    Widget? leftIcon,
    String? title,
    Widget? rightIcon,
    Function()? onTap,
    BorderRadius? borderRadius,
    Color? bgColor,
    EdgeInsets? padding,
    EdgeInsets? margin,
    double? height,
    double? width,
    TextStyle? titleStyle,
  }) {
    return SecondaryZincButton(
      key: key,
      leftIcon: leftIcon ?? this.leftIcon,
      title: title ?? this.title,
      rightIcon: rightIcon ?? this.rightIcon,
      onTap: onTap ?? this.onTap,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      bgColor: bgColor ?? this.bgColor,
      borderRadius: borderRadius ?? this.borderRadius,
      height: height ?? this.height,
      width: width ?? this.width,
      titleStyle: titleStyle ?? this.titleStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: padding ?? ZincPadding.hv24By16,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: bgColor,
        ),
        child: super.build(context),
      ),
    );
  }

  factory SecondaryZincButton.normal({
    Widget? leftIcon,
    String? title,
    Widget? rightIcon,
    Function()? onTap,
    Color? bgColor,
    double? height,
    double? width,
    EdgeInsets? padding,
    EdgeInsets? margin,
    BorderRadius? borderRadius,
    TextStyle? titleStyle,
  }) {
    return SecondaryZincButton(
      leftIcon: leftIcon,
      title: title,
      rightIcon: rightIcon,
      onTap: onTap,
      bgColor: bgColor ?? GreyscaleSurface().subtle,
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius ?? ZincBorderRadius.l,
      titleStyle: titleStyle ??
          const ZincTextStyle.normalBold().copyWith(
            color: GreyscaleText().title,
          ),
    );
  }

  factory SecondaryZincButton.disabled({
    Widget? leftIcon,
    String? title,
    Widget? rightIcon,
    Function()? onTap,
    Color? bgColor,
    double? height,
    double? width,
    EdgeInsets? padding,
    EdgeInsets? margin,
    BorderRadius? borderRadius,
    TextStyle? titleStyle,
  }) {
    return SecondaryZincButton(
      leftIcon: leftIcon,
      title: title,
      rightIcon: rightIcon,
      onTap: null,
      bgColor: GreyscaleSurface().disabled,
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius ?? ZincBorderRadius.l,
      titleStyle: titleStyle ??
          const ZincTextStyle.normalBold().copyWith(
            color: GreyscaleText().disabled,
          ),
    );
  }

  factory SecondaryZincButton.destructive({
    Widget? leftIcon,
    String? title,
    Widget? rightIcon,
    Function()? onTap,
    Color? bgColor,
    double? height,
    double? width,
    EdgeInsets? padding,
    EdgeInsets? margin,
    BorderRadius? borderRadius,
    TextStyle? titleStyle,
  }) {
    return SecondaryZincButton(
      leftIcon: leftIcon,
      title: title,
      rightIcon: rightIcon,
      onTap: onTap,
      bgColor: GreyscaleSurface().subtle,
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius ?? ZincBorderRadius.l,
      titleStyle: titleStyle ??
          const ZincTextStyle.normalBold().copyWith(
            color: ErrorTextIcon().label,
          ),
    );
  }
}

extension SecondaryZincButtonExtension on SecondaryZincButton {
  SecondaryZincButton pill() {
    return SecondaryZincButton(
      leftIcon: leftIcon,
      title: title,
      rightIcon: rightIcon,
      onTap: onTap,
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      bgColor: bgColor,
      borderRadius: ZincBorderRadius.full,
      titleStyle: titleStyle,
    );
  }

  SecondaryZincButton circle() {
    return SecondaryZincButton(
      leftIcon: leftIcon,
      title: title,
      rightIcon: rightIcon,
      onTap: onTap,
      height: height,
      width: width,
      margin: margin,
      padding: ZincPadding.fullMedium,
      bgColor: bgColor,
      borderRadius: ZincBorderRadius.full,
      titleStyle: titleStyle,
    );
  }

  SecondaryZincButton smallCircle() {
    return SecondaryZincButton(
      leftIcon: leftIcon,
      title: title,
      rightIcon: rightIcon,
      onTap: onTap,
      height: height,
      width: width,
      margin: margin,
      padding: ZincPadding.fullSmall,
      bgColor: bgColor,
      borderRadius: ZincBorderRadius.full,
      titleStyle: titleStyle?.copyWith(
        fontSize: 14,
        height: (20 / 14),
      ),
    );
  }

  SecondaryZincButton smallButton() {
    return SecondaryZincButton(
      leftIcon: leftIcon,
      title: title,
      rightIcon: rightIcon,
      onTap: onTap,
      height: height,
      width: width,
      margin: margin,
      padding: ZincPadding.hvSmall,
      bgColor: bgColor,
      borderRadius: borderRadius,
      titleStyle: titleStyle?.copyWith(
        fontSize: 14,
        height: (20 / 14),
      ),
    );
  }
}
