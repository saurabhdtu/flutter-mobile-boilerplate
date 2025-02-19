import 'package:flutter/material.dart';
import 'package:zinc/lob/remittance/common/help.dart';

class ZincAppBar extends AppBar {
  ZincAppBar(
    BuildContext context,
    String page, {
    super.key,
    Widget? leadingIcon,
    Widget? title,
    double? toolbarHeight,
    Widget? customAction,
    bool showHelp = false,
  }) : super(
            elevation: 0,
            toolbarHeight: toolbarHeight ?? 56.0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            scrolledUnderElevation: 0,
            actions: [
              if (customAction != null) customAction,
              if (showHelp)
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: HelpWidget(page),
                ),
            ],
            leading: leadingIcon ?? null,
            title: title,
            centerTitle: false,
            titleSpacing: 0);
}
