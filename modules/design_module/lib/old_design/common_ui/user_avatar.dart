import 'package:utility_module/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:design_module/old_design/common_ui/text.dart';
import 'package:design_module/old_design/resources/color_manager.dart';

class UserAvatar extends StatelessWidget {
  final String name;
  final double radius;
  final double textSize;

  const UserAvatar(this.name, {this.radius = 32, this.textSize = 24, super.key});

  @override
  Widget build(BuildContext context) => CircleAvatar(
      radius: radius,
      backgroundColor: _getAvatarColor(),
      child: Center(
          child: TextSatoshiBold(name.initials(),
              fontSize: textSize, color: Colors.white)));

  final List<Color> _avatarColors = const [
    ColorManager.color21D060,
    ColorManager.color09B447,
    ColorManager.colorE5866A,
    ColorManager.color4FD27E,
    ColorManager.color8F3519,
    ColorManager.colorB1980C,
    ColorManager.color078935,
    ColorManager.color8F3519,
    ColorManager.color1A1C26,
    ColorManager.color03211C,
    ColorManager.lightGreen
  ];

  Color _getAvatarColor() {
    int totalVal = 0;
    for (var char in name.toLowerCase().characters) {
      totalVal += char.codeUnitAt(0);
    }
    return _avatarColors[totalVal % _avatarColors.length];
  }
}
