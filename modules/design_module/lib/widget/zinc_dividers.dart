import 'package:design_module/resources/zinc_style_colors.dart';
import 'package:flutter/material.dart';

class ZincDivider extends StatelessWidget {
  final Color dividerColor;
  final double height;
  final double? thickness;
  final double? indent;
  final double? endIndent;

  const ZincDivider._(this.dividerColor, this.height,
      {this.indent, this.endIndent, this.thickness});

  @override
  Widget build(BuildContext context) => Divider(
      color: dividerColor,
      height: height,
      indent: indent,
      endIndent: endIndent);
  static final dividerGrey = ZincDivider._(GreyscaleBorder().defaultC, 1.0);
  static final dividerGreyDisabledWithSpace = ZincDivider._(
      GreyscaleBorder().disbaled, 16.0,
      indent: 3, endIndent: 3, thickness: 1.0);
  static final dividerIndent16 = ZincDivider._(
      GreyscaleBorder().disbaled, 16.0,
      indent: 16, endIndent: 16, thickness: 1.0);
  static final dividerSubtle32 = ZincDivider._(
      GreyscaleBorder().subtle, 32.0, thickness: 1.0);
}
