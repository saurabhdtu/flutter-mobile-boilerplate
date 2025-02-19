import 'dart:convert';

import 'package:common_module/app_config/app_config_model.dart';
import 'package:common_module/remote_config.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class AppConfigManager {
  static final AppConfigManager _instance = AppConfigManager._internal();

  AppConfig? _appConfig;

  AppConfigManager._internal();

  static AppConfigManager get instance => _instance;

  Future<void> initialize(FirebaseRemoteConfig config, String environment) async {
    String configString = config.getString(RemoteConfigKeys.appConfig);
    Map<String, dynamic> configData = json.decode(configString);
    // Handle conditional values for the environment
    if (configData.containsKey('parameters')) {
      final parameters = configData['parameters'];
      Map<String, dynamic> environmentValues = {};
      parameters.forEach((key, value) {
        if (value.containsKey('conditionalValues') &&
            value['conditionalValues'].containsKey(environment)) {
          environmentValues[key] =
              value['conditionalValues'][environment]['value'];
        } else if (value.containsKey('defaultValue')) {
          environmentValues[key] = value['defaultValue']['value'];
        }
      });

      // Create and assign the app config based on parsed values
      _appConfig = AppConfig.fromJson(environmentValues);
    }
  }

  // Getter for AppConfig
  AppConfig get config {
    if (_appConfig == null) {
      throw Exception("AppConfig is not initialized. Call initialize() first.");
    }
    return _appConfig!;
  }
}
