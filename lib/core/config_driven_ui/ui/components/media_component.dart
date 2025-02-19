import 'package:design_module/constants.dart';
import 'package:design_module/widget/zinc_image.dart';
import 'package:flutter/material.dart';
import 'package:zinc/domain/bff/ui_configuration/ui_component_models.dart';

class MediaComponentWidget extends StatelessWidget {
  final MediaComponent mediaComponent;
  MediaComponentWidget(this.mediaComponent);
  @override
  Widget build(BuildContext context) {
    switch (mediaComponent.mediaType) {
      case null:
      case IllustrationType.lottie:
      case IllustrationType.video:
        return SizedBox.shrink();
      case IllustrationType.image:
      case IllustrationType.serverSvg:
        return ZincImage.networkAsset(imageUrl: mediaComponent.url);
      case IllustrationType.asset:
        return ZincImage.imageAsset(imageName: mediaComponent.url);
      case IllustrationType.localSvg:
        return ZincImage.iconAsset(iconName: mediaComponent.url);
      case IllustrationType.flutterIcon:
        return ZincImage.flutterIcon(
          icon: IconData(
              int.parse(
                  mediaComponent.url.startsWith("0x")
                      ? mediaComponent.url.substring(2)
                      : mediaComponent.url,
                  radix: 16),
              fontFamily: 'MaterialIcons'),
        );
    }
  }
}
