import 'package:design_module/old_design/common_ui/pageview_indicator.dart';
import 'package:design_module/resources/zinc_colors.dart';
import 'package:flutter/material.dart';
import 'package:zinc/core/config_driven_ui/ui/ui_component_creator.dart';
import 'package:zinc/domain/bff/ui_configuration/ui_component_models.dart';

class CarouselComponentWidget extends StatefulWidget {
  final CarouselComponent carouselComponent;

  CarouselComponentWidget(this.carouselComponent);

  @override
  State<StatefulWidget> createState() => CarouselComponentWidgetState();
}

class CarouselComponentWidgetState extends State<CarouselComponentWidget> {
  int _selectedPage = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: double.infinity,
      child: Column(
        children: [
          PageView(
              onPageChanged: (value) {
                // to do :- change to bloc
                setState(() {
                  _selectedPage = value;
                });
              },
              controller: _pageController,
              children: widget.carouselComponent.children
                  .map((e) => e.getWidget())
                  .toList()),
          if (widget.carouselComponent.showIndicator)
            PageViewDotIndicator(
              currentItem: _selectedPage,
              size: const Size(9.0, 9.0),
              margin: const EdgeInsets.symmetric(horizontal: 2.0),
              count: widget.carouselComponent.children.length,
              unselectedColor: ZincColors.zincGrey,
              selectedColor: Colors.black87,
              duration: const Duration(milliseconds: 200),
              boxShape: BoxShape.circle,
              onItemClicked: (index) {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                );
              },
            )
        ],
      ),
    );
  }
}
