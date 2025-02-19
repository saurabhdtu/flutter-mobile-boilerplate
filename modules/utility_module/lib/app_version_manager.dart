import 'package:common_module/model/app_version.dart';
import 'package:common_module/remote_config.dart';

class AppVersionManager {
  AppVersionManager._privateConstructor();

  static final AppVersionManager _instance =
      AppVersionManager._privateConstructor();

  static AppVersionManager get instance {
    // Ensure initialization happens here if needed
    if (!_initialized) {
      _instance._initialize();
      _initialized = true;
    }
    return _instance;
  }

  static bool _initialized = false;

  late AppVersion _appVersion;

  AppVersion get appVersion => _appVersion;

  Future<void> _initialize() async {
    // Load app version during initialization
    await _instance.loadAppVersion();
  }

  Future<void> loadAppVersion() async {
    _appVersion = await RemoteConfigManager.getInstance.getJsonData(
      RemoteConfigKeys.appVersion,
      (json) => AppVersion.fromJson(json),
    );
  }
}
