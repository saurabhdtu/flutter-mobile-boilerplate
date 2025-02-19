
import 'package:analytics_module/tracker/base_tracker.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class FirebaseTracker extends BaseTracker {
  late FirebaseAnalytics _analytics;

  @override
  Future<void> init({dynamic config}) {
    _analytics = FirebaseAnalytics.instance;
    return Future.value();
  }

  @override
  Future<void> setUserIdentity(String userId) {
    return _analytics.setUserId(
        id: userId, callOptions: AnalyticsCallOptions(global: true));
  }

  @override
  Future<void> trackEvent(String eventName,
      {Map<String, dynamic>? properties}) {
    final props =
        properties?.map((key, value) => MapEntry(key, value.toString()));
    return _analytics.logEvent(name: eventName, parameters: props);
  }

  @override
  Future<void> trackUserProperties(Map<String, dynamic> properties) {
    return Future.forEach(properties.entries, (element) {
      FirebaseCrashlytics.instance
          .setCustomKey(element.key, element.value.toString());
      _analytics.setUserProperty(
          name: element.key, value: element.value.toString());
    });
  }

  @override
  Future<void> resetOnLogout() {
    return Future.value();
  }
}
