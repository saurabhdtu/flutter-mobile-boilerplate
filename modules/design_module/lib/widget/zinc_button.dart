import 'package:flutter/material.dart';

class ZincButton extends StatelessWidget {
  final Widget? leftIcon;
  final String? title;
  final Widget? rightIcon;
  final Function()? onTap;
  final double? height;
  final double? width;
  final TextStyle? titleStyle;

  const ZincButton(
      {Key? key,
      this.leftIcon,
      this.title,
      this.rightIcon,
      this.onTap,
      this.height,
      this.width,
      this.titleStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (leftIcon != null) ...[leftIcon!],
        if (title != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              title!,
              style: titleStyle,
            ),
          ),
        ],
        if (rightIcon != null) ...[rightIcon!],
      ],
    );
  }
}
