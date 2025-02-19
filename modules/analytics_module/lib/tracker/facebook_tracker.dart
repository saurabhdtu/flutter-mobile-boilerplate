import 'package:analytics_module/tracker/base_tracker.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:utility_module/logger/logger.dart';

class FacebookTracker extends BaseTracker {
  FacebookAppEvents? _facebookAppEvents;

  @override
  Future<void> init({dynamic config}) {
    _facebookAppEvents = FacebookAppEvents();
    return Future.value();
  }

  @override
  Future<void> resetOnLogout() async {
    await _facebookAppEvents?.clearUserID();
    return _facebookAppEvents?.clearUserData() ?? Future.value();
  }

  @override
  Future<void> setUserIdentity(String userId) {
    return _facebookAppEvents?.setUserID(userId) ?? Future.value();
  }

  @override
  Future<void> trackEvent(String eventName,
      {Map<String, dynamic>? properties}) {
    logMessage("facebook_event $eventName tracked");
    _facebookAppEvents?.logEvent(name: eventName, parameters: properties);
    return Future.value();
  }

  @override
  Future<void> trackUserProperties(Map<String, dynamic> properties) async {
    final names = properties["full_name"].toString().split(" ");
    String fName = "";
    String lName = "";
    if (names.isNotEmpty) fName = names.first;
    if (names.length > 1) {
      lName = names
          .sublist(1)
          .fold("", (previousValue, element) => previousValue + " " + element);
    }
    return _facebookAppEvents?.setUserData(
            email: properties['email'],
            gender: properties['gender'],
            phone: properties['phone_number'],
            firstName: fName,
            lastName: lName,
            dateOfBirth: properties['date_of_birth']) ??
        Future.value();
  }
}
