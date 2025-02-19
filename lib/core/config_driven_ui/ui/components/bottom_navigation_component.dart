import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:zinc/core/config_driven_ui/ui/components/media_component.dart';
import 'package:zinc/domain/bff/ui_configuration/ui_component_models.dart';

class BottomNavigationWidget extends StatefulWidget {
  final BottomNavigationComponent bottomNavigationComponent;

  BottomNavigationWidget(this.bottomNavigationComponent);

  @override
  State<StatefulWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < widget.bottomNavigationComponent.children.length; i++) {
      children.add(
        _buildNavItem(i),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 5)
        ],
      ),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: children),
    );
  }

  Widget _buildNavItem(int index) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.bottomNavigationComponent.children[index].icon != null)
            MediaComponentWidget(
                widget.bottomNavigationComponent.children[index].icon!),
          const SizedBox(height: 3.0),
          if (widget.bottomNavigationComponent.children[index].label != null)
            Text(
              widget.bottomNavigationComponent.children[index].label!,
              style: ZincTextStyle.tinySemiBold(
                  color: index == currentIndex
                      ? widget
                          .bottomNavigationComponent.children[index].activeColor
                      : widget.bottomNavigationComponent.children[index]
                          .inactiveColor),
            )
        ],
      ),
    );
  }
}
