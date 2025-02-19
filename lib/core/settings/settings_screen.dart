import 'package:design_module/resources/zinc_style_colors.dart';
import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:design_module/widget/zinc_icons.dart';
import 'package:design_module/widget/zinc_image.dart';
import 'package:flutter/material.dart';
import 'package:analytics_module/analytics_module.dart';
import 'package:analytics_module/events/events.dart';
import 'package:go_router/go_router.dart';
import 'package:zinc/app/router.dart';
import 'package:zinc/constants/strings.dart';
import 'package:zinc/lob/remittance/common/scaffold.dart';
import 'package:design_module/old_design/common_ui/text.dart';
import 'package:design_module/old_design/resources/color_manager.dart';
import 'package:design_module/resources/dimens.dart';

class SettingsScreen extends StatefulWidget {
  static const pageName = "settings";

  const SettingsScreen() : super(key: const ValueKey(pageName));

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return ZincScaffold.scaffold(
        context,
        SettingsScreen.pageName,
        Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.screenHorizontalPadding),
            child: SingleChildScrollView(
                child: Column(children: [_getDeleteAccountView()]))),
        title: AppStrings.settings);
  }

  _getDeleteAccountView() {
    return InkWell(
        onTap: () {
          Analytics.getInstance.trackEvent(
              ButtonClickEvent(SettingsScreen.pageName, "delete_account"));
          context.pushNamed(CommonRoutes.deleteAccount);
        },
        child: Padding(
            padding:
                const EdgeInsets.only(top: AppDimens.screenVerticalPadding),
            child: Column(children: [
              Row(children: [
                ZincImage.iconAsset(
                  iconName: "ic_delete.svg",
                  isCircle: true,
                  radius:24.0,
                  bgColor: GreyscaleSurface().subtle,
                ),
                const SizedBox(width: 12.0),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(
                        AppStrings.deleteAcc,
                        style: ZincTextStyle.moderateBold(
                            color: GreyscaleText().title),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        AppStrings.deleteAccDesc,
                        style: ZincTextStyle.smallRegular(
                            color: GreyscaleText().title),
                        textAlign: TextAlign.center,
                      ),
                    ])),
                const SizedBox(width: 16.0),
                zincIcon("ic_arrow_right.svg")
              ])
            ])));
  }

  @override
  void initState() {
    super.initState();
    Analytics.getInstance.trackEvent(PageLoadEvent(SettingsScreen.pageName));
  }
}
