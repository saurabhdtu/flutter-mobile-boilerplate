import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_ONBOARDING_SCREEN = "PREFS_KEY_ONBOARDING_SCREEN";
const String PREFS_KEY_WALLET_ONBOARDING_SCREEN =
    "PREFS_KEY_WALLET_ONBOARDING_SCREEN";
const String PREFS_KYC_REF_NUMBER = "PREFS_KYC_REF_NUMBER";
const String PREFS_BENEFICIARY_ID = "PREFS_BENEFICIARY_ID";
const String PREFS_STUDENT_ID = "PREFS_STUDENT_ID";
const String PREFS_KYC_STAGE = "PREFS_KYC_STAGE";
const String PREFS_KEY_USER_ID = "PREFS_KEY_USER_ID";
const String PREFS_KEY_EMAIL = "PREFS_KEY_EMAIL";

class AppPreferences {
  static AppPreferences? _instance;

  AppPreferences._();

  static AppPreferences get getInstance => _instance ??= AppPreferences._();

  Future<bool> setString(final String key, final String? value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(key, value ?? "");
  }

  Future<String> getString(final String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key) ?? "";
  }

  Future<bool> setInt(final String key, final int value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setInt(key, value);
  }

  Future<int> getInt(final String key, {int defaultValue = 0}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(key) ?? defaultValue;
  }

  Future<bool> setBool(final String key, final bool value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setBool(key, value);
  }

  Future<bool> getBool(String key, {bool defaultValue = false}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key) ?? defaultValue;
  }

  Future<bool> removeKey(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.remove(key);
  }
}

abstract class PrefKeys {
  static const firstLaunch = "first_app_launch";
  static const authToken = "PREFS_KEY_TOKEN";
  static const isLoggedIn = "PREFS_KEY_IS_USER_LOGGED_IN";
  static const deepLinkData = "DEEP_LINK_DATA";
}
