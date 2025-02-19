import 'dart:io';

import 'package:analytics_module/tracker/base_tracker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:moengage_flutter/moengage_flutter.dart';
import 'package:utility_module/logger/logger.dart';

class MoEngageTracker extends BaseTracker {
  MoEngageFlutter? _moengagePlugin;
  PushClickHandler? _pushClickHandler;

  void _convertFullNameAndPush(List<String> fullName) {
    String lastName = "";
    String firstName = fullName.first;
    try {
      if (fullName.isNotEmpty) {
        _moengagePlugin?.setFirstName(firstName);
        if (fullName.length > 1) {
          lastName = fullName.sublist(1).join(" ");
        }
        if (lastName.trim() != "") {
          _moengagePlugin?.setLastName(lastName);
        }
      }
    } catch (e) {
      logMessage(
          "got error while setting first and lastName of user into moengage: ${e.toString()} ");
    }
  }

  @override
  Future<void> init({dynamic config}) {
    if (config is String) {
      _moengagePlugin =
          MoEngageFlutter(config); //currently using test dashboard app id
      _moengagePlugin?.setPushClickCallbackHandler((data) {
        _pushClickHandler?.onPushClick(data.data.payload);
      });
      _moengagePlugin?.initialise();
      _moengagePlugin?.enableAdIdTracking();
      _moengagePlugin?.requestPushPermissionAndroid();
      _moengagePlugin?.registerForPushNotification();
      (Platform.isAndroid
              ? (FirebaseMessaging.instance.getToken())
              : FirebaseMessaging.instance.getAPNSToken())
          .then((token) {
        if (token != null) {
          _moengagePlugin?.passFCMPushToken(token);
        }
      });
      _moengagePlugin?.configureLogs(LogLevel.DEBUG,
          isEnabledForReleaseBuild: kDebugMode);
    }
    return Future.value();
  }

  @override
  Future<void> resetOnLogout() {
    _moengagePlugin?.logout();
    return Future.value();
  }

  @override
  Future<void> setUserIdentity(String userId) {
    _moengagePlugin?.setUniqueId(userId);
    return Future.value();
  }

  @override
  Future<void> trackEvent(String eventName,
      {Map<String, dynamic>? properties}) {
    var moeProperties = MoEProperties();

    if (properties != null) {
      properties.forEach((key, value) {
        moeProperties.addAttribute(key, value);
      });
    }

    try {
      _moengagePlugin?.trackEvent(
        eventName,
        moeProperties,
      );
    } catch (e) {
      logMessage("moeTrackEvent error:  ${e.toString()}");
    }
    logMessage(
      "TRIGGED EVENT NAME: $eventName , PAYLOAD : ${moeProperties.toString()}",
    );
    return Future.value();
  }

  @override
  Future<void> trackUserProperties(Map<String, dynamic> properties) {
    try {
      properties.forEach((key, value) {
        if (value != null) {
          if (key == "email") {
            _moengagePlugin?.setEmail(value.toString());
          }
          if (key == "full_name") {
            _convertFullNameAndPush(value.toString().split(" "));
          }
          if (key == "phone_number") {
            _moengagePlugin?.setPhoneNumber(value.toString());
          }
          if (key == "gender") {
            switch (value.toString().toLowerCase()) {
              case "male":
                _moengagePlugin?.setGender(MoEGender.male);
                break;
              case "female":
                _moengagePlugin?.setGender(MoEGender.female);
              case "other":
                _moengagePlugin?.setGender(MoEGender.other);
            }
          }
          _moengagePlugin?.setUserAttribute(key, value.toString());
        }
      });
    } catch (e) {
      logMessage("moeTrackEvent trackUserProperties error:  ${e.toString()}");
    }
    logMessage(
      "TRIGGERED EVENT NAME: track user properties",
    );

    return Future.value();
  }

  Future<void> trackUserLocation(double lat, double long) {
    try {
      _moengagePlugin?.setUserAttributeLocation(
          "locationAttribute", MoEGeoLocation(lat, long));
    } catch (e) {
      logMessage("moeTrackEvent trackUserLocation error:  ${e.toString()}");
    }

    return Future.value();
  }

  void setPushClickHandler(PushClickHandler? pushClickHandler) =>
      _pushClickHandler = pushClickHandler;
}

abstract class PushClickHandler {
  void onPushClick(Map<String, dynamic> data);
}
