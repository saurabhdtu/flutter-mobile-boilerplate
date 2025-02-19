import 'package:design_module/old_design/resources/font_manager.dart';
import 'package:design_module/old_design/resources/styles_manager.dart';
import 'package:design_module/old_design/resources/values_manager.dart';
import 'package:design_module/old_design/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class ProcessingDialog {
  ProcessingDialog({required this.context});

  final BuildContext context;
  BuildContext? dialogContext;

  void showProcessingDialog() {
    if (dialogContext != null && dialogContext!.mounted) {
      dialogContext?.pop();
    }
    if (!context.mounted) {
      return;
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        dialogContext = ctx;
        return _getPopUpDialog(context, [LoadingIndicator()]);
      },
    );
  }

  void dismissProcessingDialog() {
    if (dialogContext != null && dialogContext!.mounted) {
      dialogContext?.pop();
    }
  }

  Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s14)),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: ColorManager.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSize.s14),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: AppSize.s12,
                  offset: Offset(AppSize.s0, AppSize.s12))
            ]),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [_getLoadingIndicator(), _getText()]));
  }

  Padding _getLoadingIndicator() {
    return Padding(
        child: Container(
            child: CircularProgressIndicator(
              strokeWidth: 6,
              color: ColorManager.lightGreen,
            ),
            width: 32,
            height: 32),
        padding: EdgeInsets.symmetric(horizontal: 16));
  }

  Text _getText() {
    return Text(
      "Please wait..",
      style: getBoldStyle(color: ColorManager.greyText, fontSize: FontSize.s14),
      textAlign: TextAlign.center,
    );
  }
}
