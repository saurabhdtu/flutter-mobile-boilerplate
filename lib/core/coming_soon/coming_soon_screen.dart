import 'package:common_module/base/base_screen.dart';
import 'package:design_module/resources/dimens.dart';
import 'package:design_module/resources/zinc_colors.dart';
import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:design_module/widget/zinc_image.dart';
import 'package:design_module/widget/zinc_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:zinc/constants/strings.dart';
import 'package:zinc/core/application/application_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ComingSoonScreen extends StatefulWidget {
  static const pageName = "coming_soon";

  const ComingSoonScreen() : super(key: const ValueKey(pageName));

  @override
  State<StatefulWidget> createState() => _ComingSoonScreenState();
}

class _ComingSoonScreenState extends BaseScreenState<ComingSoonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ComingSoon(),
    );
  }

  @override
  String get pageName => ComingSoonScreen.pageName;
}

class ComingSoon extends StatelessWidget {
  const ComingSoon() : super(key: const ValueKey("coming_soon"));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.screenHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 32.0),
              child: Row(children: [
                ZincImage.iconAsset(
                    width: 80.0,
                    iconName: "ic_zinc_logo_dark.svg",
                    isCircle: false),
                const Spacer()
              ])),
          ZincImage.imageAsset(
              isCircle: false,
              imageName: "img_coming_soon.webp",
              imageWidth: MediaQuery.of(context).size.width - 40),
          Padding(
            padding: const EdgeInsets.only(top:20.0, bottom: 10.0),
            child: Text(AppStrings.youAreNext,
                textAlign: TextAlign.center,
                style: ZincTextStyle.superLargeExtraBold(
                    color: ZincColors.zincGrey.shade900)),
          ),
          Text(AppStrings.closedForNow,
              textAlign: TextAlign.center,
              style: ZincTextStyle.normalSemiBold(
                  color: ZincColors.zincGrey.shade800)),
          const Spacer(),
          Text(AppStrings.discover,
              textAlign: TextAlign.center,
              style: ZincTextStyle.smallRegular(
                  color: ZincColors.zincGrey.shade800)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: PrimaryZincButton.normal(
              title: AppStrings.visitWebsite,
              onTap: () {
                launchUrl(Uri.parse(ApplicationBloc.appURLs.website!));
              },
            ),
          ),
        ],
      ),
    );
  }
}
