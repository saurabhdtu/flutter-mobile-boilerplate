import 'package:design_module/constants.dart';
import 'package:flutter/material.dart';
import 'package:zinc/core/config_driven_ui/ui/components/text_component.dart';
import 'package:zinc/domain/bff/ui_configuration/ui_component_models.dart';

class BannerComponentWidget extends StatelessWidget {
  final BannerComponent bannerComponent;

  BannerComponentWidget(this.bannerComponent);

  @override
  Widget build(BuildContext context) {
    switch (bannerComponent.bannerType) {
      case null:
        return const SizedBox.shrink();
      case BannerType.small:
        return Container(
            height: 60.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextComponentWidget(textComponents: bannerComponent.title),
                const SizedBox(height: 8.0),
                TextComponentWidget(textComponents: bannerComponent.description)
              ],
            ));
      case BannerType.medium:
        return Container(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextComponentWidget(textComponents: bannerComponent.title),
                const SizedBox(height: 8.0),
                TextComponentWidget(textComponents: bannerComponent.description)
              ],
            ));
      case BannerType.large:
        return Container(
          height: 160.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextComponentWidget(textComponents: bannerComponent.title),
              const SizedBox(height: 8.0),
              TextComponentWidget(textComponents: bannerComponent.description)
            ],
          ),
        );
    }
  }
}
