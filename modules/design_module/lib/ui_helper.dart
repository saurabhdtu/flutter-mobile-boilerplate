import 'package:cached_network_image/cached_network_image.dart';
import 'package:design_module/constants.dart';
import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:utility_module/extensions/string_extensions.dart';

class UIWidgetHelper {
  UIWidgetHelper._();

  static UIWidgetHelper? _instance;

  static UIWidgetHelper get instance => _instance ??= UIWidgetHelper._();

  static Widget getLottieAsset(String name,
      {double width = double.infinity, double lottieRatio = 1}) {
    return Center(
        child: Lottie.network(name,
            repeat: true,
            animate: true,
            width: width,
            height: width / lottieRatio));
  }

  static Widget getImage(
      String? imageUrl, double? ratio, double width, BuildContext context) {
    double height = 0;
    if (ratio != null) height = width / ratio;
    return !imageUrl.isEmptyOrNull()
        ? CachedNetworkImage(
            imageUrl: imageUrl!,
            width: width,
            height: height,
            fit: BoxFit.fitWidth)
        : const SizedBox.shrink();
  }

  IllustrationType? getMediaType(String? mediaType) {
    switch (mediaType) {
      case "image":
        return IllustrationType.image;
      case "flutter_icon":
        return IllustrationType.flutterIcon;
      case "local_svg":
        return IllustrationType.localSvg;
      case "remote_svg":
        return IllustrationType.serverSvg;
      case "lottie":
        return IllustrationType.lottie;
      case "video":
        return IllustrationType.video;
      default:
        return null;
    }
  }

  TextStyle? getTextStyle(int? weight, int? size, Color? color) {
    if (weight != null && size != null) {
      final style = ZincTextStyle.weightFontMappings[weight]?[size];
      if (style == null) {
        return ZincTextStyle.smallRegular().copyWith(
            fontWeight: FontWeight.values[(weight ~/ 100) - 1],
            color: color,
            fontSize: size.toDouble());
      }
      return style.copyWith(color: color);
    }
    return null;
  }

  BannerType? getBannerType(String? type) {
    switch (type) {
      case "small":
        return BannerType.small;
      case "medium":
        return BannerType.medium;
      case "large":
        return BannerType.large;
      default:
        return null;
    }
  }

  CardType? getCardType(String? type) {
    switch (type) {
      case "small":
        return CardType.small;
      case "medium":
        return CardType.medium;
      case "large":
        return CardType.large;
      default:
        return null;
    }
  }

  TextCapitalization getTextCapitalization(String? textCapitalization) {
    switch (textCapitalization) {
      case "words":
        return TextCapitalization.words;
      case "characters":
        return TextCapitalization.characters;
      case "sentences":
        return TextCapitalization.sentences;
      default:
        return TextCapitalization.none;
    }
  }

  TextInputType getTextInputType(String? inputType) {
    switch (inputType) {
      case "number":
        return TextInputType.number;
      case "phone":
        return TextInputType.phone;
      case "email":
        return TextInputType.emailAddress;
      case "name":
        return TextInputType.name;
      case "multiline":
        return TextInputType.multiline;
      case "url":
        return TextInputType.url;
      default:
        return TextInputType.text;
    }
  }

  FilePickerLaunchMode getFilePickerLaunchMode(String? launchMode) {
    switch (launchMode) {
      case "local_storage":
        return FilePickerLaunchMode.localStorage;
      case "camera_image_front":
        return FilePickerLaunchMode.cameraImageFront;
      case "camera_image_back":
        return FilePickerLaunchMode.cameraImageBack;
      default:
        return FilePickerLaunchMode.unknown;
    }
  }

  ClickAction getClickAction(String? action) {
    switch (action) {
      case "next":
        return ClickAction.next;
      case "previous":
        return ClickAction.previous;
      case "route":
        return ClickAction.route;
      case "form_submit":
        return ClickAction.formSubmit;
    }
    return ClickAction.none;
  }

  PageType getPageType(String? type) {
    switch (type) {
      case "email_verification":
        return PageType.emailVerification;
      case "aadhar_verification":
        return PageType.aadharVerification;
      case "form":
        return PageType.form;
      case "passport_verification":
        return PageType.passportVerification;
    }
    return PageType.none;
  }
}
