import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:utility_module/app_utils.dart';
import 'package:utility_module/extensions/date_time_extensions.dart';
import 'package:utility_module/logger/log_message.dart';
import 'package:utility_module/logger/log_util.dart';
import 'package:utility_module/logger/logger.dart';

class LogView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LogViewState();

  const LogView();
}

class _LogViewState extends State<LogView> {
  int _currentPage = 0;
  int _maxPage = 0;
  List<File> _files = [];
  List<LogMessage?>? _logs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          Row(
            children: [
              if (_currentPage > 0)
                InkWell(
                  onTap: () => _loadFileAtIndex(_currentPage - 1),
                  child: Icon(
                    size: 36.0,
                    Icons.navigate_before,
                    color: Colors.black,
                  ),
                ),
              const SizedBox(width: 20.0),
              if (_currentPage < _maxPage - 1)
                InkWell(
                  onTap: () => _loadFileAtIndex(_currentPage + 1),
                  child: Icon(
                    size: 36.0,
                    Icons.navigate_next,
                    color: Colors.black,
                  ),
                ),
              const Spacer(),
              InkWell(
                onTap: () {
                  LogUtil.getInstance.clearLogs();
                  _loadLogs();
                },
                child: Icon(
                  size: 36.0,
                  Icons.delete,
                  color: Colors.black,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  size: 36.0,
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    final log = _logs![index];
                    if (log == null) return const SizedBox.shrink();
                    List<Widget> children = [
                      Text(DateTime.fromMillisecondsSinceEpoch(log.timeStamp)
                          .formatToTZFormat())
                    ]..addAll(_logWidget(log));
                    return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: children);
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                        thickness: 1.5, color: Colors.grey, height: 20.0);
                  },
                  itemCount: _logs?.length ?? 0))
        ]),
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
    _loadLogs();
  }

  void _loadLogs() {
    LogUtil.getInstance.getListOfLogFiles().then((result) {
      _files = result;
      _maxPage = _files.length;
      _currentPage = 0;
      _logs?.clear();
      if (_maxPage == 0) {
        setState(() {});
      } else {
        _loadFileAtIndex(_currentPage);
      }
    });
  }

  _loadFileAtIndex(int index) async {
    final f = _files[index];
    String data = await f.readAsString();
    data = data.replaceFirst(LogUtil.logSeparator, "");
    var entries = data.split(LogUtil.logSeparator);
    _logs = entries.map((element) {
      try {
        final data = jsonDecode(element) as Map;
        return LogMessage.fromJson(data);
      } catch (e, stack) {
        logMessage(e.toString());
        debugPrintStack(stackTrace: stack);
        return null;
      }
    }).toList().reversed.toList();
    setState(() {
      _currentPage = index;
    });
  }

  List<Widget> _logWidget(LogMessage log) {
    try {
      final decode = jsonDecode(log.message);
      if (decode is Map) {
        Map<dynamic, dynamic> json = decode;
        return json.entries.map((e) {
          final value = e.value is Map || e.value is List
              ? jsonEncode(e.value)
              : e.value.toString();

          return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              e.key.toString() + ": ",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0),
            ),
            Expanded(
              child: GestureDetector(
                onDoubleTap: () {
                  AppUtils.copyToClipboard(value);
                },
                child: SelectableText(
                  value,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.0),
                ),
              ),
            ),
          ]);
        }).toList();
      }
    } catch (e) {}
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Message" + ": ",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0),
          ),
          Expanded(
            child: SelectableText(
              log.message,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.0),
            ),
          ),
        ],
      ),
    ];
  }
}
