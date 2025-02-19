import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:utility_module/logger/logger.dart';

class ScrollTracker {
  ScrollController? _controller;
  final BuildContext _context;
  final Map<String, DateTime> _widgetEntryTimes = {};
  final Map<String, Duration> _widgetTimesSpent = {};
  final Map<String, GlobalKey> widgetKeys = {}; // Dynamic keys
  double _maxScrollPercentage = -1;
  bool _logMessage = true;
  ScrollEventListener? _scrollEventListener;

  set scrollEventListener(ScrollEventListener value) {
    _scrollEventListener = value;
  }

  ScrollTracker(this._context);

  set controller(ScrollController value) {
    _controller = value;
    _addListener();
  }

  void _scrollListener() {
    FocusScope.of(_context).unfocus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      double maxScrollExtent = _controller?.position.maxScrollExtent ?? 0;
      double currentScroll = _controller?.position.pixels ?? 0;
      if (currentScroll == maxScrollExtent) {
        _scrollEventListener?.onScrolledToEnd();
      }
      if (maxScrollExtent > 0) {
        double scrollPercentage = (currentScroll / maxScrollExtent) * 100;
        _maxScrollPercentage =
            max(_maxScrollPercentage, scrollPercentage).roundToDouble();
      }
      if (_controller?.hasClients == true) {
        widgetKeys.entries.forEach((entry) {
          // Get the current context of the widget using the GlobalKey
          BuildContext? context = entry.value.currentContext;
          if (context != null) {
            // Calculate the position of the widget
            // Calculate the scroll percentage and log it

            final RenderBox renderBox = context.findRenderObject() as RenderBox;
            final position = renderBox.localToGlobal(Offset.zero);

            // Check if the widget is inside the viewport
            if (position.dy >= 0 &&
                position.dy <= MediaQuery.of(context).size.height) {
              if (!_widgetEntryTimes.containsKey(entry.key)) {
                // Widget just entered the viewport, record the entry time
                _widgetEntryTimes[entry.key] = DateTime.now();
              }
            } else {
              if (_widgetEntryTimes.containsKey(entry.key)) {
                // Widget just exited the viewport, calculate the time spent
                final DateTime entryTime = _widgetEntryTimes[entry.key]!;
                final timeInViewport = DateTime.now().difference(entryTime);

                // Add time spent in viewport to total time
                _widgetTimesSpent[entry.key] =
                    (_widgetTimesSpent[entry.key] ?? Duration()) +
                        timeInViewport;
                _widgetEntryTimes.remove(entry.key);
              }
            }
          }
        });
        _logDetails();
      }
    });
  }

  void _logDetails() {
    if (_logMessage && kDebugMode) {
      Future.delayed(Duration(milliseconds: 2000), () {
        _logMessage = true;
        String message = "Max Scroll: $_maxScrollPercentage%\n";
        _widgetTimesSpent.forEach((key, value) {
          message += "$key: ${value.inSeconds}\n";
        });
        logMessage(message);
      });
    }
    _logMessage = false;
  }

  // Call this method when a new item is added to the list (pagination)
  void addItemKey(String key, GlobalKey value) {
    widgetKeys[key] = value;
  }

  void _addListener() {
    _controller?.addListener(_scrollListener);
  }

  void dispose() {
    _controller?.removeListener(_scrollListener);
  }
}

abstract class ScrollEventListener {
  // add more events here to listen to scroll
  void onScrolledToEnd();
}
