import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:design_module/widget/zinc_image.dart';
import 'package:flutter/material.dart';
import 'package:zinc/constants/strings.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 35, 16, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ZincImage.imageAsset(
                  imageName: 'logo_full.png',
                  isCircle: false,
                  bgColor: Colors.black,
                  imageColor: Colors.white,
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(AppStrings.zincFooterDesc,
                      textAlign: TextAlign.center,
                      style:
                          ZincTextStyle.moderateSemiBold(color: Colors.white)),
                ),
                const SizedBox(height: 25.0),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: const Color(0xFF141414),
            padding: const EdgeInsets.all(12),
            child: Center(
              child: Text(
                AppStrings.madeWithLove,
                style: ZincTextStyle.normalBold(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
