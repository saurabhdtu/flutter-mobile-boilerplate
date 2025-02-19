import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:utility_module/logger/log_message.dart';
import 'package:utility_module/logger/log_util.dart';

logError(err, {StackTrace? trace}) {
  logMessage(err.toString());
  debugPrintStack(stackTrace: trace);
  if (err is Exception) {
    FirebaseCrashlytics.instance.recordError(err, trace, fatal: false);
  }
  if (kDebugMode) {
    //_logToFile();
  }
}

logMessage(String message,
    {bool isCritical = false, bool writeToFile = false}) {
  if (kDebugMode) debugPrint("log: $message");
  if (isCritical || !kDebugMode) {
    FirebaseCrashlytics.instance.log(message);
  }
  if (writeToFile) {
    LogUtil.getInstance.logToFile(LogMessage(
        timeStamp: DateTime.now().millisecondsSinceEpoch, message: message));
  }
}


