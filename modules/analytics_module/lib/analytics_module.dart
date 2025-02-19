import 'dart:convert';
import 'package:analytics_module/events/base_event.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:common_module/app_config/app_config_model.dart';
import 'package:flutter/foundation.dart';
import 'package:utility_module/app_prefs.dart';
import 'package:utility_module/logger/logger.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:analytics_module/events/events.dart';
import 'package:analytics_module/tracker/base_tracker.dart';
import 'package:analytics_module/tracker/facebook_tracker.dart';
import 'package:analytics_module/tracker/firebase_tracker.dart';
import 'package:analytics_module/tracker/mix_panel_tracker.dart';
import 'package:analytics_module/tracker/mo_engage_tracker.dart';

import 'constants.dart';

class Analytics {
  static Analytics? _instance;
  final _firebaseTracker = FirebaseTracker();
  final _mixPanelTracker = MixPanelTracker();
  final _moengageTracker = MoEngageTracker();
  AppsflyerSdk? appsflyerSdk;
  final _facebookTracker = FacebookTracker();
  bool isInitialized = false;

  Analytics._() {
    _trackers = [];
  }

  static Analytics get getInstance => _instance ??= Analytics._();
  late List<BaseTracker> _trackers;

  Future<void> init(
      {dynamic config, PushClickHandler? pushClickHandler}) async {
    if (config is AppConfig) {
      _trackers.add(_firebaseTracker);
      _trackers.add(_mixPanelTracker);
      _trackers.add(_moengageTracker);
      _trackers.add(_facebookTracker);
      //moenegage initialization is completely synchronous internally and
      // can be initialized outside Future block without any wait
      _moengageTracker.setPushClickHandler(pushClickHandler);
      _moengageTracker.init(config: config.moEngageId);
      await Future.wait([
        _initAppsFlyer(config),
        _firebaseTracker.init(),
        _facebookTracker.init(),
        _mixPanelTracker.init(config: config.mixpanelToken)
      ]);

      isInitialized = true;
      return Future.value();
    }
    throw ("App config not provided");
  }

  Future<void> resetOnLogout() {
    Future.wait(_trackers.map((e) => e.resetOnLogout()));
    return Future.value();
  }

  Future<void> setUserIdentity(String userId) {
    FirebaseCrashlytics.instance.setUserIdentifier(userId);
    Future.wait(_trackers.map((e) => e.setUserIdentity(userId)));
    return Future.value();
  }

  Future<void> trackEvent(final BaseAnalyticsEvent event) {
    for (final platform in event.platformsToTrack) {
      event.properties?.removeWhere((key, value) => value == null);
      switch (platform) {
        case AMPlatform.firebase:
          _firebaseTracker.trackEvent(event.eventName,
              properties: event.properties);
        case AMPlatform.mixpanel:
          _mixPanelTracker.trackEvent(event.eventName,
              properties: event.properties);
        case AMPlatform.moengage:
          _moengageTracker.trackEvent(event.eventName,
              properties: event.properties);
      }
    }
    return Future.value();
  }

  Future<void> trackUserProperties(Map<String, dynamic> properties) {
    _facebookTracker.trackUserProperties(properties);
    Future.wait(_trackers.map((e) => e.trackUserProperties(properties)));
    return Future.value();
  }

  Future<dynamic> _initAppsFlyer(AppConfig config) async {
    AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
        afDevKey: config.appsFlyerKey,
        appId: config.appStoreid,
        showDebug: kDebugMode,
        timeToWaitForATTUserAuthorization: 50,
        disableAdvertisingIdentifier: false,
        disableCollectASA: false); // Optional field
    appsflyerSdk = AppsflyerSdk(appsFlyerOptions);
    appsflyerSdk?.onAppOpenAttribution((data) {
      logMessage("Step------------------------> 121 $data");
    });
    appsflyerSdk?.onInstallConversionData((data) {
      logMessage("Step------------------------> 122 $data");
    });
    appsflyerSdk?.onDeepLinking((DeepLinkResult dp) {
      logMessage("deeplink status ${dp.status}");
      switch (dp.status) {
        case Status.FOUND:
          logMessage("deeplink ${dp.deepLink?.toString()}");
          AppPreferences.getInstance.setString(
              PrefKeys.deepLinkData, jsonEncode(dp.deepLink?.clickEvent));
          logMessage("deep link value: ${dp.deepLink?.deepLinkValue}");
          break;
        case Status.NOT_FOUND:
        case Status.ERROR:
        case Status.PARSE_ERROR:
        default:
      }
    });
    return appsflyerSdk?.initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: true,
        registerOnDeepLinkingCallback: true);
  }

  Future<bool?> trackAppsFlyerEvent(AppsFlyerEvent event) async {
    bool? result;
    try {
      _facebookTracker.trackEvent(event.eventName,
          properties: event.properties);
      _firebaseTracker.trackEvent(event.eventName,
          properties: event.properties);
      result = await appsflyerSdk?.logEvent(event.eventName, null);
    } on Exception catch (e) {
      logError(e);
    }
    return result;
  }
}
