import 'dart:convert';

import 'package:common_module/app_config/app_config_manager.dart';
import 'package:common_module/remote_config.dart'; // Adjust the import as necessary
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../remote_config_test/remote_config_tests.mocks.dart';

void main() {
  late AppConfigManager appConfigManager;
  late MockFirebaseRemoteConfig mockRemoteConfig;

  setUp(() {
    appConfigManager = AppConfigManager.instance;
    mockRemoteConfig = MockFirebaseRemoteConfig();
  });

  group('AppConfigManager', () {
    test('should initialize successfully with valid config', () async {
      // Mocking the FirebaseRemoteConfig response
      final configString = "{\r\n          \"parameters\": {\r\n            \"BASE_URL\": {\r\n              \"defaultValue\": {\r\n                \"value\": \"https:\/\/api.example.com\"\r\n              },\r\n              \"conditionalValues\": {\r\n                \"dev\": {\r\n                  \"value\": \"https:\/\/api.example.com\"\r\n                },\r\n                \"prod\": {\r\n                  \"value\": \"https:\/\/api.example.com\"\r\n                }\r\n              }\r\n            },\r\n            \"MIXPANEL_TOKEN\": {\r\n              \"defaultValue\": {\r\n                \"value\": \"ABCD\"\r\n              },\r\n              \"conditionalValues\": {\r\n                \"dev\": {\r\n                  \"value\": \"EDFGH\"\r\n                },\r\n                \"prod\": {\r\n                  \"value\": \"HIJK\"\r\n                }\r\n              }\r\n            },\r\n            \"MOENGAGE_ID\": {\r\n              \"defaultValue\": {\r\n                \"value\": \"ABCD\"\r\n              },\r\n              \"conditionalValues\": {\r\n                \"dev\": {\r\n                  \"value\": \"EFGH\"\r\n                },\r\n                \"prod\": {\r\n                  \"value\": \"HIJK\"\r\n                }\r\n              }\r\n            },\r\n            \"HV_APP_ID\": {\r\n              \"defaultValue\": {\r\n                \"value\": \"ABCD\"\r\n              },\r\n              \"conditionalValues\": {\r\n                \"dev\": {\r\n                  \"value\": \"EFGH\"\r\n                },\r\n                \"prod\": {\r\n                  \"value\": \"HIJK\"\r\n                }\r\n              }\r\n            },\r\n            \"HV_API_KEY\": {\r\n              \"defaultValue\": {\r\n                \"value\": \"ABCD\"\r\n              },\r\n              \"conditionalValues\": {\r\n                \"dev\": {\r\n                  \"value\": \"EFGH\"\r\n                },\r\n                \"prod\": {\r\n                  \"value\": \"HIJK\"\r\n                }\r\n              }\r\n            },\r\n            \"apps_flyer_key\": {\r\n              \"defaultValue\": {\r\n                \"value\": \"ABCD\"\r\n              },\r\n              \"conditionalValues\": {\r\n                \"dev\": {\r\n                  \"value\": \"EFGH\"\r\n                },\r\n                \"prod\": {\r\n                  \"value\": \"HIJK\"\r\n                }\r\n              }\r\n            },\r\n            \"app_store_id\": {\r\n              \"defaultValue\": {\r\n                \"value\": \"ABCD\"\r\n              },\r\n              \"conditionalValues\": {\r\n                \"dev\": {\r\n                  \"value\": \"EFGH\"\r\n                },\r\n                \"prod\": {\r\n                  \"value\": \"HIJK\"\r\n                }\r\n              }\r\n            }\r\n          }\r\n        }";
      try {
        when(mockRemoteConfig.getString(RemoteConfigKeys.appConfig))
            .thenReturn(configString);
      } catch (ex, stack) {
        debugPrintStack(stackTrace: stack);
      }

      await appConfigManager.initialize(mockRemoteConfig, 'prod');

      final appConfig = appConfigManager.config;

      expect(appConfig.baseUrl, 'https://api.example.com');
      expect(appConfig.mixpanelToken, 'HIJK');
      expect(appConfig.moEngageId, 'HIJK');
      expect(appConfig.hvAppId, 'HIJK');
      expect(appConfig.hvApiKey, 'HIJK');
      expect(appConfig.appsFlyerKey, 'HIJK');
      expect(appConfig.appStoreid, 'HIJK');
    });

    test('should use default values when conditional values are missing',
        () async {
      final configString = json.encode({
        'parameters': {
          'appConfig': {
            'conditionalValues': {},
            'defaultValue': {
              'value': {
                'BASE_URL': 'https://api.default.com',
                'MIXPANEL_TOKEN': 'defaultMixpanelToken',
                'MOENGAGE_ID': 'defaultMoEngageId',
                'HV_APP_ID': 'defaultHvAppId',
                'HV_API_KEY': 'defaultHvApiKey',
                'apps_flyer_key': 'defaultAppsFlyerKey',
                'app_store_id': 'defaultAppStoreId',
              },
            },
          },
        },
      });

      when(mockRemoteConfig.getString(RemoteConfigKeys.appConfig))
          .thenReturn(configString);

      await appConfigManager.initialize(mockRemoteConfig, 'prod');

      final appConfig = appConfigManager.config;

      expect(appConfig.baseUrl, 'https://api.default.com');
      expect(appConfig.mixpanelToken, 'defaultMixpanelToken');
      expect(appConfig.moEngageId, 'defaultMoEngageId');
      expect(appConfig.hvAppId, 'defaultHvAppId');
      expect(appConfig.hvApiKey, 'defaultHvApiKey');
      expect(appConfig.appsFlyerKey, 'defaultAppsFlyerKey');
      expect(appConfig.appStoreid, 'defaultAppStoreId');
    });

    test(
        'should throw an exception when accessing config before initialization',
        () {
      expect(
          () => appConfigManager.config,
          throwsA(isA<Exception>().having(
              (e) => e.toString(), 'message', contains('not initialized'))));
    });
  });
}
