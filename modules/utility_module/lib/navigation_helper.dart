import 'dart:io';
import 'package:flutter/services.dart';

class NavigationHelper {
  void closeApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }
}
