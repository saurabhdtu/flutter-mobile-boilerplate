import 'package:flutter/services.dart';

abstract class UtilityMethodChannel {
  static const MethodChannel platformChannel =
      MethodChannel("com.zinc.money/platform");
  static const MethodChannel jailBreakDetection =
      MethodChannel("flutter_jailbreak_detection");

  static const jailBroken = "jailbroken";
  static const developerMode = "developerMode";
}

abstract class UtilityConstants{
  static int oneMb = 1024*1024;
}