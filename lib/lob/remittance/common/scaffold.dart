import 'package:analytics_module/analytics_module.dart';
import 'package:analytics_module/events/events.dart';
import 'package:design_module/resources/zinc_bg_decoration.dart';
import 'package:design_module/resources/zinc_style_colors.dart';
import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:design_module/widget/zinc_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:utility_module/logger/log_view.dart';
import 'package:zinc/app/constant.dart';
import 'package:zinc/constants/strings.dart';
import 'package:zinc/core/application/application_bloc.dart';
import 'package:zinc/lob/remittance/common/appbar.dart';
import 'package:zinc/lob/remittance/common/help.dart';

abstract class ZincScaffold {
  static Widget scaffold(
    BuildContext context,
    String pageName,
    Widget child, {
    Widget? leadingIcon,
    Widget? footer,
    String? title,
    ImageProvider? backgroundImage,
    bool showAppBar = true,
    bool showLeadingIcon = true,
    bool showLogout = false,
    bool showHelp = true,
    resizeToAvoidBottomInset = true,
    Widget? customAction,
    Widget? floatingActionButton,
    Color? backgroundColor,
    Function? onBackPressed,
  }) =>
      Scaffold(
          extendBody: backgroundImage != null,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          backgroundColor: backgroundColor ?? Colors.white,
          bottomNavigationBar: footer,
          extendBodyBehindAppBar: backgroundImage != null,
          floatingActionButton: floatingActionButton,
          appBar: showAppBar && backgroundImage == null
              ? ZincAppBar(context, pageName,
                  leadingIcon: showLeadingIcon
                      ? _backIcon(context, onBackPressed, pageName)
                      : null,
                  title: title != null
                      ? Text(title, style: ZincTextStyle.moderateBold())
                      : null,
                  showHelp: showHelp,
                  customAction: customAction ??
                      (showLogout
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: InkWell(
                                  onTap: () {
                                    context
                                        .read<ApplicationBloc>()
                                        .logoutUser(context);
                                  },
                                  child: Text(AppStrings.logout,
                                      style: ZincTextStyle.moderateSemiBold(
                                          color: SecondarySurface().defaultC))),
                            )
                          : null))
              : PreferredSize(
                  preferredSize: const Size(0.0, 0.0),
                  child: Container(),
                ),
          body: backgroundImage != null
              ? SafeArea(
                  child: Container(
                      decoration: ZincBgDecoration.decorate(
                          backgroundImage: backgroundImage,
                          bgFit: BoxFit.cover),
                      child: showAppBar
                          ? Column(children: [
                              SizedBox(
                                height: 56,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _backIcon(
                                          context, onBackPressed, pageName),
                                      if (title != null)
                                        Text(title,
                                            style:
                                                ZincTextStyle.moderateBold()),
                                      const Spacer(),
                                      if (showHelp)
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: HelpWidget(pageName),
                                        ),
                                    ]),
                              ),
                              Expanded(child: child)
                            ])
                          : child),
                )
              : SafeArea(child: child));

  static Widget _backIcon(
          BuildContext context, Function? onBackPressed, String pageName) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Analytics.getInstance
                .trackEvent(ButtonClickEvent(pageName, "back_button"));
            if (onBackPressed != null)
              onBackPressed.call();
            else if (context.canPop()) {
              context.pop(Constant.backIconPressed);
            } else {
              SystemNavigator.pop();
            }
          },
          onLongPress: () {
            if (kDebugMode || appFlavor == 'dev')
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LogView()));
          },
          child: ZincImage.iconAsset(
              padding: const EdgeInsets.all(1.0),
              height: 24.0,
              width: 24.0,
              isCircle: true,
              bgColor: GreyscaleSurface().subtle,
              radius: 30.0,
              iconName: "ic_arrow_left.svg"),
        ),
      );
}
