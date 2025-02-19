import 'package:design_module/resources/dimens.dart';
import 'package:design_module/resources/zinc_style_colors.dart' as zinc_colors;
import 'package:design_module/resources/zinc_style_border_radius.dart';
import 'package:flutter/material.dart';

class ZincCheckBox extends StatefulWidget {
  final Color borderColor;
  final Color surfaceColor;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? iconColor;

  const ZincCheckBox({
    super.key,
    required this.borderColor,
    required this.surfaceColor,
    required this.value,
    required this.onChanged,
    this.iconColor,
  });

  factory ZincCheckBox.primary({
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ZincCheckBox(
      borderColor: value
          ? zinc_colors.PrimaryBorder().defaultC
          : zinc_colors.GreyscaleText().subtitle,
      surfaceColor: value
          ? zinc_colors.PrimarySurface().defaultC
          : zinc_colors.GreyscaleSurface().white,
      value: value,
      onChanged: onChanged,
    );
  }

  factory ZincCheckBox.disabled({
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ZincCheckBox(
      borderColor: zinc_colors.GreyscaleBorder().disbaled,
      surfaceColor: value
          ? zinc_colors.GreyscaleSurface().disabled
          : zinc_colors.GreyscaleSurface().white,
      value: value,
      onChanged: onChanged,
      iconColor: zinc_colors.GreyscaleText().disabled,
    );
  }

  factory ZincCheckBox.success({
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ZincCheckBox(
      borderColor: zinc_colors.SuccessBorder().defaultC,
      surfaceColor: zinc_colors.SuccessSurface().defaultC,
      value: value,
      onChanged: onChanged,
    );
  }

  factory ZincCheckBox.error({
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ZincCheckBox(
      borderColor: zinc_colors.ErrorBorder().darker,
      surfaceColor: zinc_colors.ErrorSurface().darker,
      value: value,
      onChanged: onChanged,
    );
  }

  @override
  _ZincCheckBoxState createState() => _ZincCheckBoxState();
}

class _ZincCheckBoxState extends State<ZincCheckBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Container(
        width: AppDimens.checkboxSize,
        height: AppDimens.checkboxSize,
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.borderColor,
            width: 2.0,
          ),
          color: widget.value ? widget.surfaceColor : null,
          borderRadius: ZincBorderRadius.full,
        ),
        child: widget.value
            ? Icon(
                Icons.check,
                size: 18.0,
                color:
                    widget.iconColor ?? zinc_colors.GreyscaleText().white,
              )
            : null,
      ),
    );
  }
}
