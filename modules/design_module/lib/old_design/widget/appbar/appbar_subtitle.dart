import 'package:design_module/old_design/resources/font_manager.dart';
import 'package:design_module/old_design/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:design_module/old_design/resources/color_manager.dart';
class AppbarSubtitle extends StatelessWidget {
  AppbarSubtitle({Key? key, required this.text, this.margin, this.onTap,  this.textStyle})
      : super(
          key: key,
        );

  String text;

  final TextStyle? textStyle;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: Text(
          text,
          style: textStyle ?? getRegularStyle(
            color: ColorManager.black900,
            fontSize: FontSize.s14
          ),
        ),
      ),
    );
  }
}
