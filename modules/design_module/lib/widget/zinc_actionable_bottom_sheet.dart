import 'dart:ui';

import 'package:analytics_module/analytics_module.dart';
import 'package:analytics_module/events/events.dart';
import 'package:design_module/constants.dart';
import 'package:design_module/resources/zinc_colors.dart';
import 'package:design_module/resources/zinc_style_colors.dart';
import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:design_module/widget/zinc_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class ZincActionableBottomSheet {
  static Future<dynamic> showStaticSheet({
    required BuildContext context,
    bool isDismissible = true,
    final RichText? title,
    final String? titleText,
    final String? description,
    final String? actionButtonText,
    final VoidCallback? onActionButtonPressed,
    final String? cancelButtonText,
    final VoidCallback? onCancelButtonPressed,
    final Color? bottomSheetBgColor,
    final Color? dragPillColor,
    final TextStyle? titleStyle,
    final TextStyle? descriptionStyle,
    final String? pageName,
    final String? actionButtonEventName,
    final String? cancelButtonEventName,
  }) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double bottomInset = mediaQueryData.viewInsets.bottom;
    final double availableHeight = mediaQueryData.size.height - bottomInset;

    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible,
      isScrollControlled: true,
      builder: (context) =>
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: ZincColors.black50,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: availableHeight * 0.6,
                  ),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: bottomSheetBgColor ?? GreyscaleSurface().white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            height: 4,
                            width: 40,
                            decoration: BoxDecoration(
                              color: dragPillColor ?? GreyscaleSurface().subtle,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (title != null) title,
                        if(titleText != null) Text(titleText,
                            style: titleStyle ?? ZincTextStyle.hugeExtraBold()),
                        if (description != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            description,
                            style: descriptionStyle ??
                                const ZincTextStyle.normalSemiBold().copyWith(
                                  color: GreyscaleText().subtitle,
                                ),
                          ),
                        ],
                        const SizedBox(height: 24),
                        if (actionButtonText != null)
                          SizedBox(
                            width: double.infinity,
                            child: PrimaryZincButton(
                              title: actionButtonText,
                              borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                              bgColor: GreyscaleSurface().black,
                              titleStyle: ZincTextStyle.normalSemiBold(
                                  color: GreyscaleSurface().white),
                              onTap: () {
                                if (actionButtonEventName != null) {
                                  Analytics.getInstance.trackEvent(ButtonClickEvent(
                                    pageName ?? "",
                                    actionButtonEventName,
                                  ));
                                }
                                if (onActionButtonPressed != null) {
                                  onActionButtonPressed();
                                }
                                context.pop(BottomSheetActions.actionPositive);
                              },
                            ),
                          ),
                        if (cancelButtonText != null)
                          Center(
                            child: TextButton(
                              onPressed: () {
                                if (cancelButtonEventName != null) {
                                  Analytics.getInstance.trackEvent(ButtonClickEvent(
                                    pageName ?? "",
                                    cancelButtonEventName,
                                  ));
                                }
                                if (onCancelButtonPressed != null) {
                                  onCancelButtonPressed();
                                }
                                context.pop(BottomSheetActions.actionNegative);
                              },
                              child: Text(
                                cancelButtonText,
                                style: ZincTextStyle.normalSemiBold(
                                    color: GreyscaleSurface().black),
                              ),
                            ),
                          ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
