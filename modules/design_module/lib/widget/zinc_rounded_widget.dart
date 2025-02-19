
import 'package:flutter/material.dart';

/// Rounded Widget for @CS
class RoundedWidget extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final double radius;

  const RoundedWidget({super.key, this.color, this.child, this.radius = 5.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          )),
      child: child,
    );
  }
}

Container getRoundedBorderWidget(
    {Color? color,
      Widget? child,
      double? radius,
      double? width,
      BoxDecoration? decoration}) {
  return Container(
    decoration: decoration ??
        BoxDecoration(
            border:
            Border.all(color: color ?? Colors.grey, width: width ?? 1.0),
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 5.0))),
    child: child,
  );
}