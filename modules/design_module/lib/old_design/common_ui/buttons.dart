import 'package:flutter/material.dart';
import 'package:design_module/old_design/common_ui/text.dart';
import 'package:design_module/old_design/resources/color_manager.dart';

class ZincPrimaryCTAButton extends StatelessWidget {
  final bool isVerified;
  final String activeMsg;
  final String? inActiveMsg;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double? width;
  final double height;
  final Color backgroundActiveColor;
  final double textSize;
  final Widget? iconLeft;
  final double radius;
  final Function onContinueClicked;
  final Function? onDisableContinueClicked;

  const ZincPrimaryCTAButton(this.onContinueClicked,
      {Key? key,
      this.activeMsg = "Got it",
      this.inActiveMsg,
      this.backgroundActiveColor = ColorManager.color1F1F1F,
      this.margin = const EdgeInsets.all(0.0),
      this.padding = const EdgeInsets.all(0.0),
      this.radius = 16,
      this.width,
      this.iconLeft,
      this.isVerified = true,
      this.height = 56.0,
      this.textSize = 16.0,
      this.onDisableContinueClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (isVerified) {
            onContinueClicked();
          } else if (onDisableContinueClicked != null) {
            onDisableContinueClicked!();
          }
        },
        child: Container(
            height: height,
            width: width,
            margin: margin,
            padding: padding,
            decoration: BoxDecoration(
                color: isVerified
                    ? backgroundActiveColor
                    : ColorManager.colorE8E8E8,
                borderRadius: BorderRadius.circular(radius)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              if (iconLeft != null)
                Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: iconLeft),
              TextSatoshiBold(
                  isVerified ? activeMsg : (inActiveMsg ?? activeMsg),
                  fontSize: textSize,
                  color: isVerified ? Colors.white : ColorManager.colorA9A9A9,
                  textAlign: TextAlign.center)
            ])));
  }
}

class ZincPrimaryCTAButtonRounded extends StatelessWidget {
  final bool isVerified;
  final String activeMsg;
  final String inActiveMsg;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double? width;
  final double height;
  final Color backgroundActiveColor;
  final double textSize;
  final double radius;
  final Function onContinueClicked;
  final Function? onDisableContinueClicked;

  const ZincPrimaryCTAButtonRounded(this.onContinueClicked,
      {Key? key,
      this.activeMsg = "Got it",
      this.isVerified = true,
      this.inActiveMsg = "Got it",
      this.backgroundActiveColor = ColorManager.color1F1F1F,
      this.margin = const EdgeInsets.all(0.0),
      this.padding = const EdgeInsets.all(0.0),
      this.radius = 60,
      this.width,
      this.height = 42.0,
      this.textSize = 14.0,
      this.onDisableContinueClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (isVerified) {
            onContinueClicked();
          } else if (onDisableContinueClicked != null) {
            onDisableContinueClicked!();
          }
        },
        child: Container(
            height: height,
            margin: margin,
            width: width,
            padding: padding,
            decoration: BoxDecoration(
                color: isVerified
                    ? backgroundActiveColor
                    : ColorManager.colorE8E8E8,
                borderRadius: BorderRadius.circular(radius)),
            child: Center(
                child: TextSatoshiBold(isVerified ? activeMsg : inActiveMsg,
                    fontSize: textSize,
                    color: isVerified ? Colors.white : ColorManager.colorA9A9A9,
                    textAlign: TextAlign.center))));
  }
}

class ZincSecondaryCTAButton extends StatelessWidget {
  final bool isVerified;
  final String activeMsg;
  final String inActiveMsg;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double? width;
  final double height;
  final Color backgroundActiveColor;
  final double textSize;
  final double radius;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final Function onContinueClicked;
  final Function? onDisableContinueClicked;

  const ZincSecondaryCTAButton(this.onContinueClicked,
      {Key? key,
      this.activeMsg = "Got it",
      this.inActiveMsg = "Got it",
      this.backgroundActiveColor = ColorManager.color1F1F1F,
      this.margin = const EdgeInsets.all(0.0),
      this.padding = const EdgeInsets.all(0.0),
      this.radius = 60,
      this.width,
      this.isVerified = true,
      this.height = 56.0,
      this.textSize = 14.0,
      this.leftIcon,
      this.rightIcon,
      this.onDisableContinueClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (isVerified) {
            onContinueClicked();
          } else if (onDisableContinueClicked != null) {
            onDisableContinueClicked!();
          }
        },
        child: Container(
            height: height,
            margin: margin,
            width: width,
            padding: padding,
            decoration: BoxDecoration(
                color: isVerified
                    ? ColorManager.colorF3F3F3
                    : ColorManager.colorE8E8E8,
                borderRadius: BorderRadius.circular(radius)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              if (leftIcon != null)
                Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: leftIcon!),
              Center(
                  child: TextSatoshiBold(isVerified ? activeMsg : inActiveMsg,
                      fontSize: textSize,
                      color: isVerified
                          ? ColorManager.color1A1C26
                          : ColorManager.colorA9A9A9,
                      textAlign: TextAlign.center)),
              if (rightIcon != null)
                Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: rightIcon!)
            ])));
  }
}

class ZincTertiaryCTAButton extends StatelessWidget {
  final bool isVerified;
  final String activeMsg;
  final String inActiveMsg;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double? width;
  final double height;
  final double textSize;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final Function onContinueClicked;
  final Function? onDisableContinueClicked;

  const ZincTertiaryCTAButton(this.onContinueClicked,
      {Key? key,
      this.activeMsg = "Got it",
      this.inActiveMsg = "Got it",
      this.margin = const EdgeInsets.all(0.0),
      this.padding = const EdgeInsets.all(0.0),
      this.width,
      this.isVerified = true,
      this.height = 56.0,
      this.textSize = 16.0,
      this.leftIcon,
      this.rightIcon,
      this.onDisableContinueClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (isVerified) {
            onContinueClicked();
          } else if (onDisableContinueClicked != null) {
            onDisableContinueClicked!();
          }
        },
        child: Container(
            height: height,
            margin: margin,
            width: width,
            color: Colors.transparent,
            padding: padding,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              if (leftIcon != null)
                Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: leftIcon!),
              Center(
                  child: TextSatoshiBold(isVerified ? activeMsg : inActiveMsg,
                      fontSize: textSize,
                      color: isVerified
                          ? ColorManager.color262626
                          : ColorManager.colorA9A9A9,
                      textAlign: TextAlign.center)),
              if (rightIcon != null)
                Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: rightIcon!)
            ])));
  }
}
