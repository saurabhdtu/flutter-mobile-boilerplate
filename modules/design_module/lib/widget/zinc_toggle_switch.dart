import 'package:design_module/resources/zinc_style_colors.dart';
import 'package:flutter/cupertino.dart';

class ZincSwitch extends CupertinoSwitch {
  @override
  final ValueChanged<bool>? onChanged;
  @override
  final bool value;

  final Color activeSwitchColor;
  static final Color _inactiveSwitchColor = GreyscaleSurface().disabled;

  ZincSwitch({
    super.key,
    required this.value,
    this.onChanged,
    required this.activeSwitchColor,
  }) : super(
          value: value,
          onChanged: onChanged,
          activeColor: activeSwitchColor,
          trackColor: _inactiveSwitchColor,
        );
}

class ZincToggleSwitch extends StatelessWidget {
  const ZincToggleSwitch(
      {super.key,
      required this.initialValue,
      required this.onChanged,
      this.activeSwitchColor});
  final bool initialValue;
  final ValueChanged<bool> onChanged;
  final Color? activeSwitchColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40, // do not change
      height: 22, // do not change
      child: Transform.scale(
        transformHitTests: false,
        scaleX: 0.77,
        scaleY: 0.73,
        child: ZincSwitch(
          value: initialValue,
          onChanged: onChanged,
          activeSwitchColor: activeSwitchColor ?? PrimarySurface().defaultC,
        ),
      ),
    );
  }
}
