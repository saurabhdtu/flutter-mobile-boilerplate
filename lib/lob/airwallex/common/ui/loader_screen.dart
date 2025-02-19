import 'dart:async';

import 'package:design_module/constants.dart';
import 'package:design_module/resources/dimens.dart';
import 'package:design_module/resources/zinc_style_colors.dart';
import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:design_module/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:utility_module/extensions/string_extensions.dart';

class LoaderScreen extends StatefulWidget {
  final String? _title;
  final String? _message;
  final String? _illustrationUrl;
  final IllustrationType? _illustrationType;
  final double? _illustrationRatio;
  final Duration _timeoutDuration;
  final VoidCallback _onTimeout;

  const LoaderScreen({
    super.key,
    required String title,
    required String message,
    required String illustrationUrl,
    required VoidCallback onTimeout,
    required Duration timeoutDuration,
    IllustrationType illustrationType = IllustrationType.image,
    double illustrationRatio = 1,
  })  : _timeoutDuration = timeoutDuration,
        _onTimeout = onTimeout,
        _message = message,
        _illustrationUrl = illustrationUrl,
        _illustrationType = illustrationType,
        _illustrationRatio = illustrationRatio,
        _title = title;

  @override
  _LoaderScreenState createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(widget._timeoutDuration, widget._onTimeout);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (!widget._illustrationUrl.isEmptyOrNull())
                Container(
                  decoration: BoxDecoration(
                    color: GreyscaleSurface().subtle,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: switch (widget._illustrationType) {
                    IllustrationType.image => UIWidgetHelper.getImage(
                        widget._illustrationUrl,
                        widget._illustrationRatio,
                        size.width - (2 * AppDimens.homeScreenHorizontalMargin),
                        context),
                    IllustrationType.lottie => UIWidgetHelper.getLottieAsset(
                        widget._illustrationUrl!,
                        width: size.width -
                            (2 * AppDimens.homeScreenHorizontalMargin),
                        lottieRatio: widget._illustrationRatio!),
                    _ => const SizedBox.shrink()
                  },
                ),
              const SizedBox(height: 20),
              Text(
                widget._title!,
                style: const ZincTextStyle.superLargeExtraBold(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                widget._message!,
                style:
                    ZincTextStyle.normalRegular(color: GreyscaleText().title),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
