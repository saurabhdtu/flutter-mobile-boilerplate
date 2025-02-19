import 'package:common_module/base/base_screen.dart';
import 'package:design_module/constants.dart';
import 'package:flutter/material.dart';

abstract class BaseComponentState<T extends StatefulWidget>
    extends BaseScreenState<T> implements UiComponentListener {
  @override
  Widget build(BuildContext context);
}

abstract class UiComponentListener {
  void onComponentClicked(ClickAction? action, {dynamic metaData});

  void onContentChanged(dynamic data);
}
