import 'package:design_module/resources/zinc_style_colors.dart';
import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:design_module/widget/zinc_image.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatefulWidget {
  static const pageNames = "awx_card_home";
  final int currentIndex;
  final Function(int, String) onTap;
  final Color activeColor;
  final Color inActiveColor;
  final List<String> icons;
  final List<String> pageName;
  final List<String> labels;
  final Widget? centreWidget;

  CustomBottomNavigation({
    required this.currentIndex,
    required this.onTap,
    required this.activeColor,
    required this.icons,
    required this.pageName,
    required this.labels,
    required this.inActiveColor,
    this.centreWidget,
  });

  @override
  State<StatefulWidget> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < widget.labels.length; i++) {
      children.add(_buildNavItem(i));
    }
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 5)
        ]),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: children));
  }

  Widget _buildNavItem(int index) {
    bool isActive = index ==
        widget.currentIndex + (index > widget.labels.length / 2 ? 1 : 0);
    return GestureDetector(
        onTap: () {
          widget.onTap(index, widget.pageName[index]);
        },
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: (index == (widget.icons.length / 2).floor() &&
                    widget.centreWidget != null)
                ? [
                    widget.centreWidget!,
                    const SizedBox(height: 3.0),
                    Text(widget.labels[index],
                        style: ZincTextStyle.tinySemiBold(
                            color: PrimaryBorder().defaultC))
                  ]
                : [
                    ZincImage.iconAsset(
                        iconName: widget.icons[index],
                        tint: isActive
                            ? widget.activeColor
                            : widget.inActiveColor),
                    const SizedBox(height: 3.0),
                    Text(widget.labels[index],
                        style: ZincTextStyle.tinySemiBold(
                            color: isActive
                                ? widget.activeColor
                                : widget.inActiveColor))
                  ]));
  }
}
