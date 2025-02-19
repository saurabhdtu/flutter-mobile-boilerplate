import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:design_module/constants.dart';
import 'package:design_module/resources/dimens.dart';
import 'package:design_module/resources/zinc_colors.dart';
import 'package:design_module/resources/zinc_style_colors.dart';
import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:utility_module/extensions/string_extensions.dart';

class ZincImage extends StatelessWidget {
  final EdgeInsets? padding;
  final bool isCircle;
  final double? borderRadius;
  final Color bgColor;
  final Color? textColor;
  final Widget? child;
  final Function()? onTap;

  const ZincImage._({
    this.padding,
    required this.isCircle,
    required this.bgColor,
    this.borderRadius = 0,
    this.textColor,
    this.child,
    this.onTap,
    super.key,
  });

  static const double _defaultSize = 20.0;

  factory ZincImage.iconAsset(
      {required String iconName,
      Color? tint,
      double? width,
      double? height,
      double radius = 0,
      EdgeInsets? padding,
      Color? bgColor,
      Function()? onPressed,
      bool isCircle = false}) {
    return ZincImage._(
        isCircle: isCircle,
        bgColor: bgColor ?? Colors.transparent,
        padding: padding,
        borderRadius: radius,
        onTap: onPressed,
        child: SizedBox(
          width: width,
          height: height,
          child: SvgPicture.asset(
            "${AssetPaths.svgAsset}$iconName",
            colorFilter: tint != null
                ? ColorFilter.mode(
                    tint,
                    BlendMode.srcIn,
                  )
                : null,
          ),
        ));
  }

  factory ZincImage.flutterIcon(
      {required IconData icon,
      Color? tint,
      double? size,
      double radius = 0,
      EdgeInsets? padding,
      Color? bgColor,
      Function()? onPressed,
      bool isCircle = false}) {
    return ZincImage._(
      isCircle: isCircle,
      bgColor: bgColor ?? Colors.transparent,
      padding: padding,
      borderRadius: radius,
      onTap: onPressed,
      child: Icon(
        icon,
        size: size,
        color: tint ?? Colors.black,
      ),
    );
  }

  factory ZincImage.networkAsset({
    required String imageUrl,
    bool? isCircle,
    Color? bgColor,
    EdgeInsets? padding,
    double? imageWidth,
    double? imageHeight,
    double circleRadius = 0,
    BoxFit? fit,
    Function()? onPressed,
  }) {
    return ZincImage._(
      isCircle: isCircle ?? true,
      padding: padding,
      bgColor: bgColor ?? GreyscaleBorder().subtle,
      borderRadius: circleRadius,
      onTap: onPressed,
      child: ClipRRect(
          borderRadius:
              BorderRadius.circular(isCircle == true ? imageWidth ?? 0.0 : 0.0),
          child: imageUrl.endsWith("svg")
              ? SvgPicture.network(imageUrl,
                  width: imageWidth,
                  height: imageHeight,
                  fit: fit != null
                      ? fit
                      : imageWidth != null
                          ? BoxFit.fitWidth
                          : (imageHeight != null
                              ? BoxFit.fitHeight
                              : BoxFit.fill))
              : CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: imageWidth,
                  height: imageHeight,
                  fit: fit != null
                      ? fit
                      : imageWidth != null
                          ? BoxFit.fitWidth
                          : (imageHeight != null
                              ? BoxFit.fitHeight
                              : BoxFit.fill))),
    );
  }

  factory ZincImage.imageAsset({
    required String imageName,
    bool? isCircle,
    Color? bgColor,
    Color? imageColor,
    EdgeInsets? padding,
    double borderRadius = 0,
    double? imageWidth,
    double? imageHeight,
    Function()? onPressed,
  }) {
    return ZincImage._(
      isCircle: isCircle ?? true,
      padding: padding,
      borderRadius: borderRadius,
      bgColor: bgColor ?? GreyscaleBorder().subtle,
      onTap: onPressed,
      child: Image.asset("${AssetPaths.imageAsset}$imageName",
          width: imageWidth,
          height: imageHeight,
          color: imageColor,
          fit: imageWidth != null
              ? BoxFit.fitHeight
              : (imageHeight != null ? BoxFit.fitWidth : BoxFit.fill)),
    );
  }

  factory ZincImage.memoryAsset({
    required String imageBytes,
    bool? isCircle,
    Color? bgColor,
    EdgeInsets? padding,
    double? imageWidth,
    double? imageHeight,
    double circleRadius = 0,
    BoxFit? fit,
    Function()? onPressed,
  }) {
    return ZincImage._(
      isCircle: isCircle ?? true,
      padding: padding,
      bgColor: bgColor ?? GreyscaleBorder().subtle,
      borderRadius: circleRadius,
      onTap: onPressed,
      child: ClipRRect(
          borderRadius:
              BorderRadius.circular(isCircle == true ? imageWidth ?? 0.0 : 0.0),
          child: Image.memory(base64Decode(imageBytes),
              width: imageWidth,
              height: imageHeight,
              fit: fit != null
                  ? fit
                  : imageWidth != null
                      ? BoxFit.fitWidth
                      : (imageHeight != null
                          ? BoxFit.fitHeight
                          : BoxFit.fill))),
    );
  }

  factory ZincImage.fileAsset({
    required String filePath,
    bool? isCircle,
    Color? bgColor,
    EdgeInsets? padding,
    double? imageWidth,
    double? imageHeight,
    double circleRadius = 0,
    BoxFit? fit,
    Function()? onPressed,
  }) {
    return ZincImage._(
      isCircle: isCircle ?? true,
      padding: padding,
      bgColor: bgColor ?? GreyscaleBorder().subtle,
      borderRadius: circleRadius,
      onTap: onPressed,
      child: ClipRRect(
          borderRadius:
              BorderRadius.circular(isCircle == true ? imageWidth ?? 0.0 : 0.0),
          child: Image.file(File(filePath),
              width: imageWidth,
              height: imageHeight,
              fit: fit != null
                  ? fit
                  : imageWidth != null
                      ? BoxFit.fitWidth
                      : (imageHeight != null
                          ? BoxFit.fitHeight
                          : BoxFit.fill))),
    );
  }

  factory ZincImage.initials(
      {required String userName,
      String? url,
      Color? bgColor,
      double? size,
      Function()? onPressed,
      TextStyle? style,
      Color? textColor}) {
    return ZincImage._(
        isCircle: true,
        bgColor: bgColor ?? _getAvatarColor(userName),
        onTap: onPressed,
        borderRadius: size ?? _defaultSize,
        child: url != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular((size ?? _defaultSize)),
                child: CachedNetworkImage(
                    imageUrl: url ?? "",
                    width: (size ?? _defaultSize) * 2,
                    height: (size ?? _defaultSize) * 2,
                    fit: size != null
                        ? BoxFit.fitWidth
                        : (size != null ? BoxFit.fitHeight : BoxFit.fill)))
            : SizedBox(
                width: size ?? _defaultSize,
                height: size ?? _defaultSize,
                child: Center(
                    child: Text(userName.trim().initials(),
                        textAlign: TextAlign.center,
                        style: style ??
                            ZincTextStyle.moderateBold(
                                color: textColor ?? Colors.black))),
              ));
  }

  factory ZincImage.spotIllustration({
    String? iconName,
    bool? isCircle,
    Color? bgColor,
    Function()? onPressed,
    Color? textColor,
  }) {
    return ZincImage._(
      isCircle: isCircle ?? false,
      bgColor: bgColor ?? GreyscaleSurface().defaultC,
      onTap: onPressed,
      child: Center(
        child: SizedBox(
          height: AppDimens.avatarIconSize,
          width: AppDimens.avatarIconSize,
          child: SvgPicture.asset(
            iconName != null
                ? "${AssetPaths.svgAsset}$iconName"
                : "${AssetPaths.svgAsset}ic_image_icon.svg",
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: isCircle
            ? CircleAvatar(
                radius: borderRadius,
                backgroundColor: bgColor,
                child: Padding(
                  padding: padding ?? const EdgeInsets.all(0),
                  child: child ?? const SizedBox(),
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius ?? 0),
                child: Container(
                  padding: padding ?? const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(borderRadius ?? 0)),
                  child: child ?? const SizedBox(),
                )));
  }

  static final List<Color> _avatarColors = [
    ZincColors.zincOliveGreen,
    ZincColors.zincGreen.shade500,
    ZincColors.zincGreen.shade600,
    ZincColors.zincGreen.shade700,
    ZincColors.zincGreen.shade800,
    ZincColors.zincChrome.shade300,
    ZincColors.zincChrome.shade400,
    ZincColors.zincChrome.shade500,
    ZincColors.zincChrome.shade600,
    ZincColors.zincImperialRed.shade300,
    ZincColors.zincImperialRed.shade400,
    ZincColors.zincImperialRed.shade500,
    ZincColors.zincImperialRed.shade600,
    ZincColors.zincSelectiveYellow.shade500,
    ZincColors.zincSelectiveYellow.shade600,
    ZincColors.zincSelectiveYellow.shade700,
    ZincColors.zincSelectiveYellow.shade800,
    ZincColors.zincGreen.shade400,
    ZincColors.zincGreen.shade500,
    ZincColors.zincGreen.shade600,
    ZincColors.zincGreen.shade700,
    ZincColors.zincGreen.shade800,
    ZincColors.zincGrey.shade700,
    ZincColors.zincGrey.shade900,
  ];

  static _getAvatarColor(String name) {
    int totalVal = 0;
    for (var char in name.toLowerCase().characters) {
      totalVal += char.codeUnitAt(0);
    }
    return _avatarColors[totalVal % _avatarColors.length];
  }
}
