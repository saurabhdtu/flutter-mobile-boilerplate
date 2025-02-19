import 'package:cached_network_image/cached_network_image.dart';
import 'package:design_module/constants.dart';
import 'package:design_module/old_design/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@deprecated
class ZincCircularIcon extends StatelessWidget {
  final String iconName;
  final Color bgColor;
  final Color? iconTint;
  final double radius;
  final EdgeInsets padding;
  final Function()? onTap;

  const ZincCircularIcon(
      {required this.iconName,
      this.bgColor = ColorManager.colorF8F8F8,
      this.radius = 24.0,
      this.iconTint,
      this.padding = const EdgeInsets.all(8.0),
      this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) => Padding(
      padding: padding,
      child: InkWell(
          onTap: onTap,
          child: CircleAvatar(
              backgroundColor: bgColor,
              radius: radius,
              child: SvgPicture.asset(
                "${AssetPaths.svgAsset}$iconName",
                colorFilter: iconTint != null
                    ? ColorFilter.mode(iconTint!, BlendMode.srcIn)
                    : null,
              ))));
}

Widget zincIcon(String iconName, {final double? size, final Color? tint}) =>
    SizedBox(
        width: size,
        height: size,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: SvgPicture.asset("${AssetPaths.svgAsset}$iconName",
              colorFilter: tint != null
                  ? ColorFilter.mode(tint, BlendMode.srcIn)
                  : null),
        ));

Widget zincFlutterIcon(IconData icon,
        {final double size = 32,
        final Color bgColor = ColorManager.colorE3FFED,
        final iconColor = ColorManager.color09B447}) =>
    CircleAvatar(
        radius: size,
        backgroundColor: bgColor,
        child: Center(child: Icon(icon, size: size, color: iconColor)));

Widget zincSvg(String iconName,
        {double? width, double? height, final Color? tint}) =>
    SvgPicture.asset("${AssetPaths.svgAsset}$iconName",
        width: width,
        height: height,
        colorFilter:
            tint != null ? ColorFilter.mode(tint, BlendMode.srcIn) : null);

Widget zincImageAsset(String imageName,
        {final double? width, final double? height, final Color? tint}) =>
    Padding(
        padding: const EdgeInsets.all(2.0),
        child: Image.asset("${AssetPaths.imageAsset}$imageName",
            width: width,
            height: height,
            fit: width != null
                ? BoxFit.fitWidth
                : (height != null ? BoxFit.fitHeight : BoxFit.fill)));

Widget zincNetworkAsset(String imageUrl,
        {final double? width, final double? height, final Color? tint}) =>
    Padding(
        padding: const EdgeInsets.all(2.0),
        child: CachedNetworkImage(
            imageUrl: imageUrl,
            width: width,
            height: height,
            fit: width != null
                ? BoxFit.fitWidth
                : (height != null ? BoxFit.fitHeight : BoxFit.fill)));
