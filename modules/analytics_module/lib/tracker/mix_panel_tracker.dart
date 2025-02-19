import 'package:analytics_module/tracker/base_tracker.dart';
import 'package:flutter/foundation.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

class MixPanelTracker extends BaseTracker {
  late Mixpanel _tracker;

  @override
  Future<void> init({dynamic config}) async {
    if (config == null || config is! String) throw FlutterError("Mix panel token is not initialized");
    _tracker = await Mixpanel.init(config, trackAutomaticEvents: true);
    _tracker.setLoggingEnabled(kDebugMode);
    return Future.value();
  }

  @override
  Future<void> setUserIdentity(String userId) {
    _tracker.identify(userId);
    return Future.value();
  }

  @override
  Future<void> trackEvent(String eventName,
      {Map<String, dynamic>? properties}) {
    _tracker.track(eventName, properties: properties);
    return Future.value();
  }

  @override
  Future<void> trackUserProperties(Map<String, dynamic> properties) {
    _tracker.registerSuperProperties(properties);
    return Future.value();
  }

  @override
  Future<void> resetOnLogout() {
    _tracker.reset();
    return Future.value();
  }

}
