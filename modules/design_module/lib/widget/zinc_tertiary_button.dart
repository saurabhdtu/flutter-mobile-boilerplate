import 'package:design_module/resources/zinc_style_colors.dart';
import 'package:design_module/resources/zinc_style_padding.dart';
import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:design_module/widget/zinc_button.dart';
import 'package:flutter/material.dart';

class TertiaryZincButton extends ZincButton {
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

  const TertiaryZincButton({
    Key? key,
    this.leftIcon,
    this.title,
    this.rightIcon,
    this.onTap,
    this.height,
    this.width,
    this.padding,
    this.margin,
    this.titleStyle,
  }) : super(
          key: key,
          leftIcon: leftIcon,
          title: title,
          rightIcon: rightIcon,
          onTap: onTap,
          titleStyle: titleStyle,
        );

  TertiaryZincButton copyWith({
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
    return TertiaryZincButton(
      key: key,
      leftIcon: leftIcon ?? this.leftIcon,
      title: title ?? this.title,
      rightIcon: rightIcon ?? this.rightIcon,
      onTap: onTap ?? this.onTap,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
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
        child: super.build(context),
      ),
    );
  }

  factory TertiaryZincButton.normal({
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
    return TertiaryZincButton(
      leftIcon: leftIcon,
      title: title,
      rightIcon: rightIcon,
      onTap: onTap,
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      titleStyle: titleStyle ??
          const ZincTextStyle.normalBold().copyWith(
            color: GreyscaleText().title,
          ),
    );
  }

  factory TertiaryZincButton.disabled({
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
    return TertiaryZincButton(
      leftIcon: leftIcon,
      title: title,
      rightIcon: rightIcon,
      onTap: null,
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      titleStyle: titleStyle ??
          const ZincTextStyle.normalBold().copyWith(
            color: GreyscaleText().disabled,
          ),
    );
  }

  factory TertiaryZincButton.destructive({
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
    return TertiaryZincButton(
      leftIcon: leftIcon,
      title: title,
      rightIcon: rightIcon,
      onTap: onTap,
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      titleStyle: titleStyle ??
          const ZincTextStyle.normalBold().copyWith(
            color: ErrorTextIcon().label,
          ),
    );
  }
}

extension TertiaryZincButtonExtension on TertiaryZincButton {
  ///may use in future>>>>>>>>>

  // TertiaryZincButton pill() {
  //   return TertiaryZincButton(
  //     leftIcon: leftIcon,
  //     title: title,
  //     rightIcon: rightIcon,
  //     onTap: onTap,
  //     height: height,
  //     width: width,
  //     margin: margin,
  //     padding: padding,
  //     titleStyle: titleStyle,
  //   );
  // }

  // TertiaryZincButton circle() {
  //   return TertiaryZincButton(
  //     leftIcon: leftIcon,
  //     title: title,
  //     rightIcon: rightIcon,
  //     onTap: onTap,
  //     height: height,
  //     width: width,
  //     margin: margin,
  //     padding: const EdgeInsets.all(12),
  //     titleStyle: titleStyle,
  //   );
  // }

  TertiaryZincButton smallButton() {
    return TertiaryZincButton(
      leftIcon: leftIcon,
      title: title,
      rightIcon: rightIcon,
      onTap: onTap,
      height: height,
      width: width,
      margin: margin,
      padding: ZincPadding.hvSmall,
      titleStyle: titleStyle?.copyWith(
        fontSize: 14,
        height: (20 / 14),
      ),
    );
  }
}
