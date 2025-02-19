import 'package:design_module/resources/zinc_style_colors.dart' as zinc_colors;
import 'package:flutter/material.dart';

enum ZincRadioButtonTypes { primary, success, error, disabled }

class ZincRadioButton extends StatefulWidget {
  final Color borderColor;
  final Color surfaceColor;
  final bool value;
  final ValueChanged<bool> onChanged;
  final ZincRadioButtonTypes radioBtnType;

  const ZincRadioButton({
    super.key,
    required this.borderColor,
    required this.surfaceColor,
    required this.value,
    required this.onChanged,
    required this.radioBtnType,
  });

  factory ZincRadioButton.primary({
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ZincRadioButton(
      radioBtnType: ZincRadioButtonTypes.primary,
      borderColor: value
          ? zinc_colors.PrimaryBorder().defaultC
          : zinc_colors.GreyscaleText().subtitle,
      surfaceColor: zinc_colors.PrimaryBorder().defaultC,
      value: value,
      onChanged: onChanged,
    );
  }

  factory ZincRadioButton.disabled({
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ZincRadioButton(
      radioBtnType: ZincRadioButtonTypes.disabled,
      borderColor: zinc_colors.GreyscaleText().disabled,
      surfaceColor: zinc_colors.GreyscaleText().disabled,
      value: value,
      onChanged: onChanged,
    );
  }

  factory ZincRadioButton.success({
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ZincRadioButton(
      radioBtnType: ZincRadioButtonTypes.success,
      borderColor: zinc_colors.SuccessBorder().defaultC,
      surfaceColor: zinc_colors.SuccessBorder().defaultC,
      value: value,
      onChanged: onChanged,
    );
  }

  factory ZincRadioButton.error({
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ZincRadioButton(
      radioBtnType: ZincRadioButtonTypes.error,
      borderColor: zinc_colors.ErrorBorder().darker,
      surfaceColor: zinc_colors.ErrorBorder().darker,
      value: value,
      onChanged: onChanged,
    );
  }

  @override
  _ZincRadioButtonState createState() => _ZincRadioButtonState();
}

class _ZincRadioButtonState extends State<ZincRadioButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.radioBtnType == ZincRadioButtonTypes.disabled
          ? null
          : () {
              widget.onChanged(!widget.value);
            },
      child: Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: widget.borderColor,
              width: 2.0,
            ),
            color: zinc_colors.GreyscaleSurface().white),
        child: widget.value
            ? Center(
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.surfaceColor,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
