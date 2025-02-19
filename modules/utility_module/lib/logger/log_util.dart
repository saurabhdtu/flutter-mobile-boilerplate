import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:utility_module/logger/log_message.dart';

class LogUtil {
  LogUtil._();

  static LogUtil? _logUtil;
  final maxFileLength = 1 * 1024 * 1024; //1mb
  static LogUtil get getInstance => _logUtil ??= LogUtil._();
  static const logSeparator = "<.>";

  void logToFile(LogMessage message) async {
    final logDir = await _getLogDir();
    if (logDir != null) {
      final logFile = await _getLatestLogFile(logDir);
      _writeToLogFile(message, logFile);
    }
  }

  Future<Directory?> _getLogDir() async {
    try {
      if (!kDebugMode) {
        final extDir = await getExternalStorageDirectory();
        if (extDir != null) {
          final logDir = Directory(extDir.path + _logDirPath);
          await logDir.create(recursive: true);
          debugPrint("${logDir.existsSync()}");
          return logDir;
        }
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }
    return null;
  }

  Future<File> _getLatestLogFile(Directory logDir) async {
    var listSync = await logDir.listSync();
    if (listSync.isEmpty) return _getLogFile(logDir, 0);
    List<int> fileIndices = listSync.map((e) => indexFromPath(e.path)).toList();
    int latestFileIndex = (fileIndices..sort()).last;
    final logFile = await _getLogFile(logDir, latestFileIndex);
    if ((await logFile.length()) > maxFileLength) {
      return _getLogFile(logDir, latestFileIndex + 1);
    } else {
      return logFile;
    }
  }

  String _fileNameByIndex(int index) => "zinc_logs-$index.log";

  Future<File> _getLogFile(Directory logDir, int index) async {
    final logFile = File(logDir.path + "/${_fileNameByIndex(index)}");
    if (!logFile.existsSync()) await logFile.create(recursive: true);
    return logFile;
  }

  final _logDirPath = "/logs";

  void _writeToLogFile(LogMessage message, File logFile) {
    final msg = jsonEncode(message.toJson());
    try {
      final map = jsonDecode(msg);
      debugPrint(map.toString());
    } catch (e) {
      debugPrint(msg);
    }
    logFile.writeAsStringSync(logSeparator + msg, mode: FileMode.append);
  }

  Future<List<File>> getListOfLogFiles(
      {bool orderChronoLogically = false}) async {
    final logDir = await _getLogDir();
    if (logDir != null) {
      var list = await logDir.listSync(recursive: false, followLinks: false);
      List<File> files = list.map((e) => File(e.path)).toList();
      files.sort((a, b) => orderChronoLogically
          ? indexFromPath(a.path).compareTo(indexFromPath(b.path))
          : indexFromPath(b.path).compareTo(indexFromPath(a.path)));
      return files;
    }
    return [];
  }

  void clearLogs() async {
    final dir = await _getLogDir();
    dir?.listSync().forEach((e) => e.deleteSync(recursive: true));
  }

  int indexFromPath(String path) =>
      int.parse(path.split("-").last.split(".").first);
}
