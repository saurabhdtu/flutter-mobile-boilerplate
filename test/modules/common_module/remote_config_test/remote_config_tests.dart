import 'package:common_module/remote_config.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'remote_config_tests.mocks.dart';

// Create a mock class for FirebaseRemoteConfig
@GenerateMocks([FirebaseRemoteConfig])
void main() {
  late RemoteConfigManager remoteConfigManager;
  late MockFirebaseRemoteConfig mockRemoteConfig;
  // Define a real RemoteConfigSettings object to return
  final configSettings = RemoteConfigSettings(
      fetchTimeout: Duration(minutes: 1),
      minimumFetchInterval: Duration(seconds: 1));
  setUp(() {
    mockRemoteConfig = MockFirebaseRemoteConfig();
    remoteConfigManager = RemoteConfigManager.getInstance;
    when(mockRemoteConfig.setConfigSettings(any))
        .thenAnswer((invocation) async {
      final settings =
          invocation.positionalArguments.first as RemoteConfigSettings;
      expect(settings, isNotNull); // Assert that it's not null
    });
    when(mockRemoteConfig.setDefaults({})).thenAnswer((_) async {
      return Future.value();
    });
    when(mockRemoteConfig.fetchAndActivate()).thenAnswer((_) async {
      return Future.value(true);
    });
  });

  group('RemoteConfigManager', () {
    test('should initialize RemoteConfigManager successfully', () async {
      final result = await remoteConfigManager.init(mockRemoteConfig);
      expect(result, true);
    });

    test('should return JSON data for given key', () async {
      await remoteConfigManager.init(mockRemoteConfig);
      final mockJsonString = '{"key":"value"}';
      when(mockRemoteConfig.getString('some_key')).thenReturn(mockJsonString);

      final result = remoteConfigManager.getJsonData(
        'some_key',
        (json) => json['key'] as String,
      );

      expect(result, "value");
    });

    test('should return boolean flag for given key', () async {
      await remoteConfigManager.init(mockRemoteConfig);
      when(mockRemoteConfig.getBool('feature_enabled')).thenReturn(true);

      final result = remoteConfigManager.getBoolFlag('feature_enabled');

      expect(result, true);
    });
  });
}
