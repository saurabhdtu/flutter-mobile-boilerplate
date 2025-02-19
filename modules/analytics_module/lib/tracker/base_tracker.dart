abstract class BaseTracker {
  Future<void> init({final dynamic config});

  Future<void> setUserIdentity(String userId);

  Future<void> trackEvent(String eventName, {Map<String, dynamic>? properties});

  Future<void> trackUserProperties(Map<String, dynamic> properties);

  Future<void> resetOnLogout();
}
