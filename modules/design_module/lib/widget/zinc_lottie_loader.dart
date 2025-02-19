import 'package:design_module/constants.dart';
import 'package:design_module/resources/zinc_style_colors.dart';
import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class ZincLottieLoader extends StatelessWidget {
  final String asset;
  final String message;
  final Color? messageColor;
  final double loaderSize;

  const ZincLottieLoader(
      {this.asset = "loading.json",
      this.message = "Loading content..",
      this.messageColor,
      this.loaderSize = 300.0});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        LottieBuilder.asset("${AssetPaths.lottieAsset}$asset",
            height: loaderSize, width: loaderSize, repeat: true),
        Text(message,
            style: ZincTextStyle.moderateBold(
                color: messageColor ?? GreyscaleText().title)),
        const Spacer()
      ],
    );
  }
}
