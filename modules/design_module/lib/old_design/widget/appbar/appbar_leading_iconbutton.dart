import 'package:flutter/material.dart';

import '../custom_icon_button.dart';
import '../custom_image_view.dart'; // ignore: must_be_immutable

class AppbarLeadingIconbutton extends StatelessWidget {
  const AppbarLeadingIconbutton(
      {Key? key, this.imagePath, this.margin, this.onTap})
      : super(
          key: key,
        );

  final String? imagePath;

  final EdgeInsetsGeometry? margin;

  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTap?.call();
        },
        child: Padding(
            padding: margin ?? const EdgeInsets.only(top: 16),
            child: CustomIconButton(
                height: 40,
                width: 40,
                child: CustomImageView(
                  margin: const EdgeInsets.all(6),
                  imagePath: "assets/images/img_back.svg",
                ))));
  }
}
