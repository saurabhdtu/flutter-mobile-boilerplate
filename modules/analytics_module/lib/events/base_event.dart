
import 'package:analytics_module/constants.dart';

abstract class BaseAnalyticsEvent {
  final String eventName;
  final Map<String, dynamic>? properties;
  final List<AMPlatform> platformsToTrack;

  const BaseAnalyticsEvent.event(
      {required this.eventName,
      this.properties,
      this.platformsToTrack = AMPlatform.values});
}
