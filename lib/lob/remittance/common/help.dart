import 'package:analytics_module/analytics_module.dart';
import 'package:analytics_module/events/events.dart';
import 'package:design_module/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:design_module/old_design/common_ui/text.dart';
import 'package:design_module/old_design/resources/color_manager.dart';
import 'package:design_module/old_design/widget/app_decoration.dart';
import 'package:design_module/old_design/widget/appbar/appbar_circleimage.dart';
import 'package:zinc/app/router.dart';
import 'package:zinc/constants/strings.dart';

class HelpWidget extends StatelessWidget {
  final bool isDark;
  final String pageSource;
  final double margin;
  final Function()? onClick;

  const HelpWidget(this.pageSource,
      {this.onClick, this.isDark = true, this.margin = 0.0, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick ??
          () {
            Analytics.getInstance
                .trackEvent(ButtonClickEvent(pageSource, "help"));
            // var data = "{ \"url\" : \"${ApplicationBloc.appURLs.faqUrl}\"}";
            context.pushNamed(
              CommonRoutes.supportFaqScreenView,
              // pathParameters: {'data': data},
            );
          },
      child: Container(
          margin: EdgeInsets.only(left: margin, right: margin, top: margin),
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 16.0, 8.0),
          decoration: AppDecoration.outlineOnErrorContainer.copyWith(
              borderRadius: BorderRadiusStyle.circleBorder20,
              border: Border.all(
                  color: (isDark ? Colors.black : ColorManager.white)
                      .withAlpha(85))),
          child: Row(children: [
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusStyle.circleBorder12,
                    color: ColorManager.color21D060),
                child: AppbarCircleimage(
                    imagePath: "${AssetPaths.imageAsset}img_help_girl.png")),
            const SizedBox(width: 8.0),
            TextSatoshiMedium(AppStrings.help,
                color: isDark ? Colors.black : Colors.white, fontSize: 14.0)
          ])),
    );
  }
}
