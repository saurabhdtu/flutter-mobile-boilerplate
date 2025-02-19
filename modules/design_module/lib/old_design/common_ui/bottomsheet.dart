import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:flutter/material.dart';

abstract class ZincBottomSheet {
  static Future<dynamic> showBottomSheet(BuildContext context, Widget child,
      {bool dismissible = true,
      String cta = "",
      final bool isScrollControlled = true,
      final String? title,
      final bool enableDrag = true,
      final String? description}) {
    final list = [
      if (title != null) Text(title, style: ZincTextStyle.bigExtraBold()),
      if (description != null)
        Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 15.0),
            child: Text(description, style: ZincTextStyle.moderateRegular())),
      const SizedBox(height: 15.0),
      child
    ];
    return showModalBottomSheet(
        context: context,
        isDismissible: dismissible,
        useSafeArea: true,
        isScrollControlled: isScrollControlled,
        enableDrag: enableDrag,
        barrierColor: Colors.black.withAlpha(183),
        builder: (ctx) {
          return Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))),
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 20.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: list)));
        });
  }
}
