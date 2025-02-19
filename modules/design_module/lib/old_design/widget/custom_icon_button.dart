import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/theme_helper.dart';

extension IconButtonStyleHelper on CustomIconButton {
  static BoxDecoration get fillErrorContainer => BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(24),
      );
  static BoxDecoration get fillIndigo => BoxDecoration(
        color: ColorManager.indigo5001,
        borderRadius: BorderRadius.circular(12),
      );
  static BoxDecoration get outlineGreenA => BoxDecoration(
        color: ColorManager.greenA200,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: ColorManager.greenA200.withOpacity(0.1),
          width: 12,
        ),
      );
  static BoxDecoration get fillDarkGrey => BoxDecoration(
    color: ColorManager.greyText,
    borderRadius: BorderRadius.circular(24),
  );
  static BoxDecoration get fillTeal => BoxDecoration(
    color: appTheme.teal50,
    borderRadius: BorderRadius.circular(24),
  );
  static BoxDecoration get fillGrayTL20 => BoxDecoration(
        color: ColorManager.gray5002,
        borderRadius: BorderRadius.circular(20),
      );
  static BoxDecoration get fillGreenA => BoxDecoration(
        color: ColorManager.greenA400,
        borderRadius: BorderRadius.circular(24),
      );
  static BoxDecoration get fillGray => BoxDecoration(
    color: appTheme.gray100,
    borderRadius: BorderRadius.circular(24),
  );
}

class CustomIconButton extends StatelessWidget {
  CustomIconButton(
      {Key? key,
      this.alignment,
      this.height,
      this.width,
      this.padding,
      this.decoration,
      this.child,
      this.onTap})
      : super(
          key: key,
        );

  final Alignment? alignment;

  final double? height;

  final double? width;

  final EdgeInsetsGeometry? padding;

  final BoxDecoration? decoration;

  final Widget? child;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center, child: iconButtonWidget)
        : iconButtonWidget;
  }

  Widget get iconButtonWidget => SizedBox(
        height: height ?? 0,
        width: width ?? 0,
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Container(
            height: height ?? 0,
            width: width ?? 0,
            padding: padding ?? EdgeInsets.zero,
            decoration: decoration ??
                BoxDecoration(
                  color: ColorManager.gray100,
                  borderRadius: BorderRadius.circular(24),
                ),
            child: child,
          ),
          onPressed: onTap,
        ),
      );
}
