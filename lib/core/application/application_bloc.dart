import 'dart:async';
import 'dart:convert';

import 'package:analytics_module/analytics_module.dart';
import 'package:analytics_module/events/events.dart';
import 'package:analytics_module/tracker/mo_engage_tracker.dart';
import 'package:common_module/app_config/app_config_model.dart';
import 'package:common_module/model/urls.dart';
import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:design_module/widget/zinc_actionable_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:network_module/data/network/api/dio_error_listener.dart';
import 'package:resource_download_manager_module/resource_download_manager.dart';
import 'package:resource_download_manager_module/resource_model.dart';
import 'package:utility_module/logger/logger.dart';
import 'package:zinc/app/app_prefs.dart';
import 'package:zinc/app/router.dart';
import 'package:zinc/core/application/application_events.dart';
import 'package:zinc/core/application/application_states.dart';
import 'package:zinc/constants/strings.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState>
    implements PushClickHandler, DioErrorListener {
  static late AppURLs appURLs;
  static AppConfig appConfig = AppConfig(
      baseUrl: '',
      mixpanelToken: '',
      moEngageId: '',
      hvAppId: '',
      hvApiKey: '',
      appStoreid: '',
      versionCode: '',
      versionName: '',
      appsFlyerKey: '');
  static bool? _hasLaunched;
  final _appPreferences = AppPreferences.getInstance;
  AppState appState = AppState.undefined;
  bool _isAppLaunchFired = false;
  bool isLogoutTriggered = false;
  static String? _deepLinkRoute;
  static Map<String, String>? _args;

  ApplicationBloc() : super(AppLoading()) {
    on<LogOutEvent>(_onUserLogout);
    on<DeeplinkOpened>(_handleDeepLink);
    on<NotificationClicked>(_handleNotificationClick);
  }

  Future<void> _onUserLogout(
      ApplicationEvent event, Emitter<ApplicationState> emit) async {
    isLogoutTriggered = true;
    await Future.wait([
      Analytics.getInstance.resetOnLogout(),
      _appPreferences.setBool(PrefKeys.isLoggedIn, false),
      _appPreferences.setString(PrefKeys.authToken, null),
    ]);
    emit(UserLoggedOut());
    Future.delayed(const Duration(seconds: 1), () {
      isLogoutTriggered = false;
    });
    return Future.value();
  }

  void onPaused() {
    appState = AppState.paused;
    _isAppLaunchFired = false;
  }

  void onResumed() {
    appState = AppState.resumed;
    appLaunched();
    _isAppLaunchFired = true;
  }

  void appLaunched({String? deeplink, bool isFirstLaunch = false}) {
    if (Analytics.getInstance.isInitialized && !_isAppLaunchFired) {
      Analytics.getInstance.trackEvent(AppLaunchEvent({
        "launch_type": _hasLaunched == true ? "warm_start" : "cold_start",
        "open_type": deeplink == null ? "organic" : "deeplink",
        "deep_link": deeplink,
        "first_launch": isFirstLaunch
      }));
      _hasLaunched = true;
    }
  }

  FutureOr<void> _handleDeepLink(
      DeeplinkOpened event, Emitter<ApplicationState> emit) async {
    _appPreferences.setString(PrefKeys.deepLinkData, null);
    if (event.route != CommonRoutes.awxHome) {
      logMessage("handling deeplink");
      emit(HandleDeeplinkRoute(event.route));
    }
  }

  @override
  void onPushClick(Map<String, dynamic> data) {
    logMessage("push clicked $data");
    _appPreferences.setString(PrefKeys.deepLinkData, jsonEncode(data));
  }

  FutureOr<void> _handleNotificationClick(
      NotificationClicked event, Emitter<ApplicationState> emit) {
    _appPreferences.setString(PrefKeys.deepLinkData, null);
    if (event.data.containsKey("route")) {
      logMessage("deeplink: route check ${event.data['route']}");
      if (event.data.containsKey("route_data")) {
        logMessage("deeplink: route data check ${event.data['route_data']}");
        emit(HandleDeeplinkRoute(event.data['route'],
            args: {"data": event.data['route_data']}));
      } else if (event.data.containsKey("route_param_key")) {
        logMessage(
            "deeplink: route param check ${event.data['route_param_key']}: ${event.data['route_param_value']}");
        emit(HandleDeeplinkRoute(event.data['route'], args: {
          event.data['route_param_key']: event.data['route_param_value']
        }));
      } else {
        emit(HandleDeeplinkRoute(event.data['route']));
      }
    }
  }

  @override
  void onInternetUnavailable() {}

  @override
  void onUserUnauthorized() {
    add(LogOutEvent());
  }

  downloadAssets(List<ResourceItem> assets) {
    ResourceDownloadManager.instance.startMultipleAssetDownload(assets);
  }

  void logoutUser(BuildContext context) {
    ZincActionableBottomSheet.showStaticSheet(
        context: context,
        title: RichText(
            text: TextSpan(
                text: AppStrings.signOut, style: ZincTextStyle.bigExtraBold())),
        description: AppStrings.endSession,
        actionButtonText: "${AppStrings.yes}, ${AppStrings.signOut}",
        cancelButtonText: AppStrings.no,
        onCancelButtonPressed: () {},
        onActionButtonPressed: () {
          context.pop();
          add(LogOutEvent());
        });
  }
}

enum AppState { paused, resumed, undefined }
