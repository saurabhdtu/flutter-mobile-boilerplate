import 'dart:collection';

import 'package:analytics_module/analytics_module.dart';
import 'package:analytics_module/events/events.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:utility_module/scroll_tracker.dart';

abstract class BaseScreenState<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver {
  late Trace _screenRenderingTrace;
  abstract final String pageName;
  late int _lastTimeTS;
  int _timeSpentInMs = 0;
  static const maxDepthReachedInPercentage = "max_depth";
  HashMap<String, dynamic>? _scrollMetrics = HashMap<String, dynamic>();
  late ScrollTracker scrollTracker;

  @override
  Widget build(BuildContext context);

  @override
  void initState() {
    _screenRenderingTrace =
        FirebasePerformance.instance.newTrace("${pageName}_trace");
    _screenRenderingTrace.start();
    _lastTimeTS = DateTime.now().millisecondsSinceEpoch;
    super.initState();
    scrollTracker = ScrollTracker(context);
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      _screenRenderingTrace.stop();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    Analytics.getInstance.trackEvent(ScreenTimeTrackingEvent(
        pageName,
        (_timeSpentInMs +=
                DateTime.now().millisecondsSinceEpoch - _lastTimeTS) ~/
            1000));
    scrollTracker.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        _lastTimeTS = DateTime.now().millisecondsSinceEpoch;
        break;
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        _timeSpentInMs += DateTime.now().millisecondsSinceEpoch - _lastTimeTS;
        _lastTimeTS = DateTime.now().millisecondsSinceEpoch;
        break;
    }
  }
}
