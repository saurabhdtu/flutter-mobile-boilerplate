import 'package:design_module/resources/zinc_style_colors.dart';
import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:design_module/widget/zinc_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:utility_module/logger/logger.dart';
import 'package:utility_module/constants/strings.dart';

class InAppUpdateCheck {
  Future<void> checkForUpdate(BuildContext context) async {
    try {
      final updateInfo = await InAppUpdate.checkForUpdate();
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        // If an update is available, start the flexible update
        await InAppUpdate.startFlexibleUpdate();
        showUpdateDialog(context);
      }
    } catch (e) {
      logMessage("Failed to check for update: $e");
    }
  }

  Future<void> completeUpdate() async {
    try {
      await InAppUpdate.completeFlexibleUpdate();
      logMessage("Update completed successfully");
    } catch (e) {
      logMessage("Failed to complete update: $e");
    }
  }

  void showUpdateDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (newContext) => AlertDialog(
        title: Text(
          UtilityStrings.updateAvailableExclamantion,
          style: ZincTextStyle.normalBold(),
        ),
        content: Text(
          UtilityStrings.appUpdateDialogDescription,
          style: ZincTextStyle.smallRegular(),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrimaryZincButton(
                onTap: () {
                  Navigator.of(context).pop();
                },
                title: UtilityStrings.remindMeLater,
                titleStyle: ZincTextStyle.smallBold(),
                padding: EdgeInsets.all(10),
              ),
              PrimaryZincButton.normal(
                padding: EdgeInsets.all(10),
                titleStyle:
                    ZincTextStyle.smallBold(color: GreyscaleText().white),
                onTap: () async {
                  Navigator.of(context).pop();
                  await completeUpdate();
                },
                title: UtilityStrings.updateNow,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
