import 'package:design_module/old_design/common_ui/loader.dart';
import 'package:flutter/material.dart';

mixin ScreenHelperMixin<T extends StatefulWidget> on State<T> {
  bool _isLoaderVisible = false;

  void handleLoader(BuildContext context, bool showLoader, {String? message}) {
    if (showLoader) {
      _showLoader(context, message);
    } else {
      _hideLoader(context);
    }
  }

  void _showLoader(BuildContext context, String? message) {
    if (!_isLoaderVisible) {
      _isLoaderVisible = true;
      showProgressDialog(context,
          message: message ?? "Getting things ready....");
    }
  }

  void _hideLoader(BuildContext context) {
    if (_isLoaderVisible) {
      _isLoaderVisible = false;
      Navigator.of(context).pop();
    }
  }
}
