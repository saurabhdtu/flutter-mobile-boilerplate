import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utility_module/app_prefs.dart';

void main() {
  late AppPreferences appPreferences;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    appPreferences = AppPreferences.getInstance;
    await SharedPreferences.getInstance();
  });

  group('AppPreferences Tests', () {
    test('Set and Get String', () async {
      const key = PREFS_KEY_EMAIL;
      const value = 'test@example.com';

      bool setResult = await appPreferences.setString(key, value);
      expect(setResult, isTrue);

      String getResult = await appPreferences.getString(key);
      expect(getResult, equals(value));
    });

    test('Get String with default when not set', () async {
      const key = 'NON_EXISTENT_KEY';

      String getResult = await appPreferences.getString(key);
      expect(getResult, equals(''));
    });

    test('Set and Get Int', () async {
      const key = PREFS_KYC_STAGE;
      const value = 5;

      bool setResult = await appPreferences.setInt(key, value);
      expect(setResult, isTrue);

      int getResult = await appPreferences.getInt(key);
      expect(getResult, equals(value));
    });

    test('Get Int with default when not set', () async {
      const key = 'NON_EXISTENT_INT_KEY';

      int getResult = await appPreferences.getInt(key, defaultValue: 10);
      expect(getResult, equals(10));
    });

    test('Set and Get Bool', () async {
      const key = PREFS_KEY_ONBOARDING_SCREEN;
      const value = true;

      bool setResult = await appPreferences.setBool(key, value);
      expect(setResult, isTrue);

      bool getResult = await appPreferences.getBool(key);
      expect(getResult, equals(value));
    });

    test('Get Bool with default when not set', () async {
      const key = 'NON_EXISTENT_BOOL_KEY';

      bool getResult = await appPreferences.getBool(key, defaultValue: true);
      expect(getResult, equals(true));
    });

    test('Remove Key', () async {
      const key = PREFS_KEY_USER_ID;
      const value = 'user_123';

      bool setResult = await appPreferences.setString(key, value);
      expect(setResult, isTrue);

      String getResult = await appPreferences.getString(key);
      expect(getResult, equals(value));
      bool removeResult = await appPreferences.removeKey(key);
      expect(removeResult, isTrue);
      String removedResult = await appPreferences.getString(key);
      expect(removedResult, equals(''));
    });
  });
}
