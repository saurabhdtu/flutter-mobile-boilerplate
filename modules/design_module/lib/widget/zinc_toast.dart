import 'package:design_module/resources/zinc_style_border_radius.dart';
import 'package:design_module/resources/zinc_style_colors.dart';
import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:design_module/utils/zinc_widget_utils.dart';
import 'package:design_module/widget/zinc_system_banner.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// USAGE:
/// CustomToast.showToast(
/// context: context,
/// message: "message",
/// isTop: true,
/// toastType: ZincSnackbarType.neutral,
/// autoDismissible: true,
/// leftIcon: const Icon(Icons.abc),
/// rightButtonTitle: "Retry",
/// );

class CustomToast {
  static final FToast _fToast = FToast();

  static void showToast({
    required BuildContext context,
    required String message,
    int toastDurationInMs = 2000,
    required bool isTop,
    final Widget? leftIcon,
    final String? rightButtonTitle,
    final Function()? rightButtonOnTap,
    final TextStyle? titleStyle,
    required ZincSnackbarType toastType,
    final bool? autoDismissible,
    final Color? bgColor,
  }) {
    _initToast(context);
    _showToast(
      context: context,
      message: message,
      isCenter: true,
      bgColor: bgColor,
      isDark: false,
      toastDurationInMs: toastDurationInMs,
      isTop: isTop,
      titleStyle: titleStyle,
      leftIcon: leftIcon,
      toastType: toastType,
      rightButtonOnTap: rightButtonOnTap,
      rightButtonTitle: rightButtonTitle,
      autoDismissible: autoDismissible ?? true,
    );
  }

  ///dont edit below functions
  static void _showToast({
    required BuildContext context,
    required String message,
    required bool isCenter,
    required bool isDark,
    String? rightButtonTitle,
    Widget? leftIcon,
    required Color? bgColor,
    required int toastDurationInMs,
    required bool isTop,
    TextStyle? titleStyle,
    required ZincSnackbarType toastType,
    Function()? rightButtonOnTap,
    bool autoDismissible = true,
  }) {
    _fToast.showToast(
      child: _buildCustomToast(
        message: message,
        bgColor: bgColor,
        leftIcon: leftIcon,
        titleStyle: titleStyle,
        toastType: toastType,
        rightButtonOnTap: rightButtonOnTap,
        rightButtonTitle: rightButtonTitle,
      ),
      toastDuration: Duration(
        milliseconds: !autoDismissible ? 9999999999 : toastDurationInMs,
      ),
      positionedToastBuilder: (context, child) {
        return _customPositionedToastBuilder(
          context,
          child,
          isTop,
        ); //custom positioning the toast
      },
    );
  }

  static Widget _buildCustomToast({
    required String message,
    final String? rightButtonTitle,
    final Widget? leftIcon,
    Color? bgColor,
    TextStyle? titleStyle,
    required ZincSnackbarType toastType,
    final Function()? rightButtonOnTap,
  }) {
    Color backgroundColor = bgColor ?? getSnackBarBackgroundColor(toastType);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: ZincBorderRadius.l,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            if (leftIcon != null) leftIcon,
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  message,
                  style: titleStyle ??
                      const ZincTextStyle.normalRegular()
                          .copyWith(color: GreyscaleText().white),
                ),
              ),
            ),
            if (rightButtonTitle != null) ...[
              Container(
                // padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                child: InkWell(
                  onTap: () {
                    if (rightButtonOnTap != null) {
                      rightButtonOnTap();
                    }
                    _fToast.removeCustomToast();
                  },
                  child: Text(
                    rightButtonTitle.toUpperCase(),
                    style: const ZincTextStyle.smallBold()
                        .copyWith(color: GreyscaleText().white),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  static Widget _customPositionedToastBuilder(
    BuildContext context,
    Widget child,
    bool isTop,
  ) {
    return Positioned(
      bottom: isTop
          ? null
          : MediaQuery.of(context)
              .padding
              .bottom, //adding 20 to make it look a little above screen
      top: isTop ? MediaQuery.of(context).padding.top : null,
      left: 0,
      right: 0,
      child: child,
    );
  }

  ///need to run init before creating toast
  static void _initToast(BuildContext context) {
    _fToast.init(context);
  }
}
