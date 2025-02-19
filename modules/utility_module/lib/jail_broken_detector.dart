// File: lib/jailbreak_detection.dart

import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:utility_module/utitlity_constants.dart';

class JailbreakDetection {
  final MethodChannel _channel;

  JailbreakDetection([MethodChannel? channel])
      : _channel = channel ??
            (Platform.isAndroid
                ? UtilityMethodChannel.platformChannel
                : UtilityMethodChannel.jailBreakDetection);

  Future<bool> get jailbroken async {
    bool? jailbroken =
        await _channel.invokeMethod<bool>(UtilityMethodChannel.jailBroken);
    return jailbroken ?? true;
  }

  Future<bool> get developerMode async {
    bool? developerMode =
        await _channel.invokeMethod<bool>(UtilityMethodChannel.developerMode);
    return developerMode ?? true;
  }
}
