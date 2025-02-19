import 'package:analytics_module/analytics_module.dart';
import 'package:analytics_module/events/events.dart';
import 'package:common_module/base/base_screen.dart';
import 'package:design_module/resources/dimens.dart';
import 'package:design_module/resources/zinc_style_colors.dart';
import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:design_module/widget/zinc_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:zinc/core/application/application_bloc.dart';
import 'package:zinc/constants/strings.dart';
import 'package:zinc/lob/remittance/common/scaffold.dart';
import 'package:url_launcher/url_launcher.dart';


class DeleteAccountScreen extends StatefulWidget {
  static const pageName = "delete_account";

  const DeleteAccountScreen() : super(key: const ValueKey(pageName));

  @override
  State<StatefulWidget> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends BaseScreenState<DeleteAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return ZincScaffold.scaffold(
        context, DeleteAccountScreen.pageName, _getContent(context),
        title: AppStrings.deleteAccount);
  }

  _getContent(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.screenHorizontalPadding),
        child: Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              const Spacer(),
              Text(
                AppStrings.deleteAccTitle,
                style: ZincTextStyle.superLargeExtraBold(
                    color: GreyscaleText().title),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12.0),
              Text(
                AppStrings.deleteAccPageDesc,
                style: ZincTextStyle.normalRegular(color: GreyscaleText().body),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              PrimaryZincButton.normal(
                width: double.infinity,
                title: AppStrings.callUs,
                leftIcon: const Icon(Icons.call_outlined, color: Colors.white),
                onTap: () {
                  Analytics.getInstance.trackEvent(ButtonClickEvent(
                      DeleteAccountScreen.pageName, "call_us"));
                  if (ApplicationBloc.appURLs.contactNum != null) {
                    launchUrl(Uri.parse(ApplicationBloc.appURLs.contactNum!));
                  }
                },
              ),
              const SizedBox(height: 24.0)
            ])));
  }

  @override
  void initState() {
    super.initState();
    Analytics.getInstance
        .trackEvent(PageLoadEvent(DeleteAccountScreen.pageName));
  }

  @override
  String get pageName => DeleteAccountScreen.pageName;
}
