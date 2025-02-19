import 'package:flutter/material.dart';
import '../app_decoration.dart';
import '../custom_image_view.dart'; // ignore: must_be_immutable
class AppbarCircleimage extends StatelessWidget {
  AppbarCircleimage({Key? key, this.imagePath, this.margin, this.onTap})
      : super(
          key: key,
        );

  String? imagePath;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadiusStyle.circleBorder12,
      onTap: () {
        onTap?.call();
      },
      splashFactory: NoSplash.splashFactory,
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomImageView(
          imagePath: imagePath!,
          height: 24,
          width: 24,
          fit: BoxFit.contain,
          radius: BorderRadius.circular(
            12,
          ),
        ),
      ),
    );
  }
}
