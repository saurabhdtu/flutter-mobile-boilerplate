import 'dart:convert';

import 'package:analytics_module/analytics_module.dart';
import 'package:common_module/app_config/app_config_manager.dart';
import 'package:common_module/base/base_bloc.dart';
import 'package:common_module/fresh_chat.dart';
import 'package:common_module/model/urls.dart';
import 'package:common_module/remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:network_module/data/network/api/zinc_request_response.dart';
import 'package:network_module/data/network/dio_api_client.dart';
import 'package:utility_module/app_version_manager.dart';
import 'package:utility_module/extensions/map_extensions.dart';
import 'package:utility_module/extensions/string_extensions.dart';
import 'package:utility_module/jail_broken_detector.dart';
import 'package:utility_module/logger/logger.dart';
import 'package:zinc/app/app_prefs.dart';
import 'package:zinc/app/constant.dart';
import 'package:zinc/app/router.dart';
import 'package:zinc/constants/api_endpoints.dart';
import 'package:zinc/core/application/application_bloc.dart';
import 'package:zinc/core/application/application_events.dart';
import 'package:zinc/core/splash/bloc/splash_states.dart';
import 'package:zinc/core/splash/repository/splash_repository.dart';
import 'package:zinc/lob/airwallex/router.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
class SplashBloc extends BaseCubit<SplashState> {
  late final AppPreferences _appPreferences;
  final SplashRepository _splashRepository;

  SplashBloc(this._splashRepository) : super(SplashLoading()) {
    _appPreferences = AppPreferences.getInstance;
  }

  Function? _toExecute;

  void loadSplash(ApplicationBloc applicationBloc) async {
    // Map<dynamic, dynamic>? data =
    // await AppMethodChannel.platformChannel.invokeMapMethod("get_config");
    // logMessage("config: $data");
    // ApplicationBloc.appConfig = AppConfig.fromJson(data);
    // await Analytics.getInstance.init(config: ApplicationBloc.appConfig);

    //jailBrokenCheck
    if (kReleaseMode) await _checkForJailBreak();

    try {
      await RemoteConfigManager.getInstance.init(FirebaseRemoteConfig.instance);
      AppConfigManager.instance.initialize(FirebaseRemoteConfig.instance, appFlavor ?? '');
      await initAppConfig(applicationBloc);
      await AppVersionManager.instance;
    } catch (ex) {
      logError(ex);
    }

    if (_checkForForceUpdate()) return;

    ApplicationBloc.appURLs = RemoteConfigManager.getInstance
        .getJsonData<AppURLs>(
            RemoteConfigKeys.urls, (p0) => AppURLs.fromJson(p0));
    final firstLaunch =
        await _appPreferences.getBool(PrefKeys.firstLaunch, defaultValue: true);
    _appPreferences.setBool(PrefKeys.firstLaunch, false);
    FreshchatService.initializeFreshchat();
    if (await _appPreferences.getBool(PrefKeys.isLoggedIn) == true) {
      try {
        final deeplinkData =
            await _appPreferences.getString(PrefKeys.deepLinkData);


      } catch (ex) {
        handleError(ex);
      }
    } else {
      _codeFlowCompleted = true;
      _proceed(
          () => emitState(NavigateFromSplash(CommonRoutes.phoneLoginRoute)));
    }
  }


  bool _codeFlowCompleted = false;
  bool _animationCompleted = false;

  Future<void> _checkForJailBreak() async {
    try {
      if (await _isDeviceRooted()) {
        emitState(NavigateFromSplash(CommonRoutes.jailBrokenScreenView));
        return;
      }
    } catch (e) {
      logError(e);
    }
  }

  Future<bool> _isDeviceRooted() async {
    bool jailBroken = await JailbreakDetection().jailbroken;
    bool developerMode = await JailbreakDetection().developerMode;
    // Return true if either jailBroken or developerMode is true, otherwise false
    return jailBroken || developerMode;
  }

  bool _checkForForceUpdate() {
    try {
      if ((AppVersionManager
                  .instance.appVersion.minAppVersionNumber?.versionNumber ??
              0) >
          (int.tryParse(ApplicationBloc.appConfig.versionCode) ?? 0)) {
        emitState(NavigateFromSplash(CommonRoutes.appUpdateScreenView));
        return true;
      }
    } catch (e) {
      logError(e);
    }
    return false;
  }

  Future<void> initAppConfig(ApplicationBloc applicationBloc) async {
    await AppMethodChannel.platformChannel
        .invokeMapMethod(AppMethodChannel.methodGetConfig)
        .then((data) {
      ApplicationBloc.appConfig = AppConfigManager.instance.config;
      ApplicationBloc.appConfig.versionCode = data?['version_code'] ?? '';
      ApplicationBloc.appConfig.versionName = data?['version_name'] ?? '';
      Analytics.getInstance.init(
          config: ApplicationBloc.appConfig, pushClickHandler: applicationBloc);
      DioAPIClient.initialize(
          ApplicationBloc.appConfig.baseUrl + APIEndPoints.apiVersion,ApplicationBloc.appConfig.isDev,
          applicationBloc);
      debugPrint("config: $data");
    });
  }

  @override
  void handleError(err) {
    super.handleError(err);
    if (err is ZincAPIError) emitState((SplashError(err)));
  }

  void animationComplete() {
    _animationCompleted = true;
    _proceed(null);
  }

  void _proceed(Function? toExecute) {
    _toExecute = toExecute ?? _toExecute;
    if (_animationCompleted && _codeFlowCompleted) {
      _toExecute?.call();
    }
  }
}
