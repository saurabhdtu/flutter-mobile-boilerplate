import 'package:design_module/resources/dimens.dart';
import 'package:design_module/resources/zinc_style_colors.dart';
import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:design_module/widget/zinc_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zinc/core/application/application_bloc.dart';
import 'package:zinc/constants/strings.dart';
import 'package:zinc/lob/remittance/common/scaffold.dart';

class ContactUsScreen extends StatelessWidget {
  static const _pageName = "contact_us_screen";

  const ContactUsScreen() : super(key: const ValueKey(_pageName));

  @override
  Widget build(BuildContext context) {
    return ZincScaffold.scaffold(
        context,
        _pageName,
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.screenHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.contactUs, style: ZincTextStyle.hugeExtraBold()),
              const SizedBox(height: AppDimens.screenVerticalPadding),
              _item("ic_phone.svg", AppStrings.callUs,
                  ApplicationBloc.appURLs.contactNum ?? ""),
              Divider(height: 1.0, color: GreyscaleBorder().defaultC),
              _item("ic_email.svg", AppStrings.emailUs,
                  ApplicationBloc.appURLs.contactEmail ?? "")
            ],
          ),
        ));
  }

  Widget _item(String icon, String label, String url) {
    return InkWell(
        onTap: () {
          launchUrl(Uri.parse(url));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(children: [
            ZincImage.iconAsset(
              iconName: icon,
              height: 48.0,
              width: 48.0,
              padding: const EdgeInsets.all(8.0),
              bgColor: GreyscaleSurface().subtle,
              isCircle: true,
            ),
            const SizedBox(width: 16.0),
            Expanded(
                child: Text(
              label,
              style: ZincTextStyle.moderateSemiBold(),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.screenHorizontalPadding),
              child: ZincImage.iconAsset(iconName: "ic_arrow_right.svg"),
            )
          ]),
        ));
  }
}
