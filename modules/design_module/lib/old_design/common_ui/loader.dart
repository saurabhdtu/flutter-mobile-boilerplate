import 'package:design_module/resources/zinc_colors.dart';
import 'package:design_module/resources/zinc_style_colors.dart';
import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:flutter/material.dart';

showProgressDialog(BuildContext context,
    {bool dismissible = true,
    bool barrierDismissible = false,
    String? message}) {
  showDialog(
      context: context,
      barrierColor: ZincColors.black90,
      barrierDismissible: barrierDismissible,
      useRootNavigator: true,
      builder: (ctx) {
        return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(0),
            child: PopScope(
                canPop: dismissible,
                child: Container(
                    decoration: message != null
                        ? BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(24.0),
                          )
                        : null,
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: message == null ? 45.0 : 30,
                          height: message == null ? 45.0 : 30,
                          child: CircularProgressIndicator(
                            strokeWidth: message == null ? 4 : 6,
                            backgroundColor: Colors.transparent,
                            color: SuccessBorder().defaultC,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        if (message != null)
                          Text(
                            message,
                            style: ZincTextStyle.smallSemiBold(),
                            textAlign: TextAlign.center,
                          ),
                      ],
                    ))));
      });
}
