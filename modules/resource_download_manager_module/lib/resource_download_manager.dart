import 'dart:isolate';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:resource_download_manager_module/file_operations.dart';
import 'package:resource_download_manager_module/resource_model.dart';
import 'package:utility_module/logger/logger.dart';

///-- Res Download Manager file @CS
///--1 download list of resources
///--2 download single resource with progress
///--3 check for existing resource with same filename
///--4 deletion of files in application directory
class ResourceDownloadManager {
  ResourceDownloadManager._privateConstructor();

  static final ResourceDownloadManager instance =
      ResourceDownloadManager._privateConstructor();

  Future<List<String>> downloadResourceItems(
      List<ResourceItem>? assets, Function(Map) progressListener) async {
/*    final status = await Permission.storage.request();
    if (!status.isGranted) {
      logMessage('Storage permission not granted');
      return [];
    } else {*/
      final List<Map<String, String>> downloadTasks = [];
      final directoryPath = await FileOperations.getApplicationDirectoryPath();
      final receivePort = ReceivePort();
      const Duration downloadDelay = Duration(seconds: 5);
      for (var asset in assets!) {
        final filePath = '$directoryPath/${asset.fileName}';
        downloadTasks.add({
          'url': asset.url,
          'filePath': filePath,
          'type': asset.fileType,
          'fileName': asset.fileName,
        });
      }
      logMessage('Spawning isolate for downloading assets');
      Isolate.spawn(_downloadIsolate,
          DownloadParams(receivePort.sendPort, downloadTasks, downloadDelay),
          debugName: "download_thread");

      ///receiving the result from the download process
      await for (var message in receivePort) {
        if (message is List<Map<String, String>>) {
          for (var result in message) {
            // Fluttertoast.showToast(
            //   msg: result['message']!,
            //   toastLength: Toast.LENGTH_SHORT,
            //   gravity: ToastGravity.TOP,
            // );
          }
        }
      }
      return [];
    // }
  }

  static Future<void> _downloadIsolate(DownloadParams params) async {
    final List<Map<String, String>> results = [];
    final dio = Dio();
    int downloadCount = 0;

    for (var task in params.downloadTasks) {
      final filePath = task['filePath']!;
      if (await FileOperations.checkFileExists(filePath)) {
        results.add({
          'status': 'File already exists: ${task['fileName']}',
          'message':
              'File already exists: ${task['type']}\n${task['fileName']}',
        });
        logMessage('File already exists: ${task['fileName']}');
        params.sendPort.send(results);
        results.clear();
        continue;
      }
      try {
        logMessage('Downloading: ${task['url']} to $filePath');
        await dio.download(task['url']!, filePath,
            onReceiveProgress: (count, total) {
          params.sendPort.send(count);
        });
        results.add({
          'status': 'Downloaded: ${task['fileName']}',
          'message':
              'Downloaded ${task['type']} ${++downloadCount}/${params.downloadTasks.length}',
        });
        logMessage('Downloaded: ${task['fileName']}');
        params.sendPort.send(results);
        results.clear();
        // Add delay after each download
        // await Future.delayed(params.downloadDelay);
      } catch (e) {
        results.add({
          'status': 'Failed to download ${task['fileName']}: $e',
          'message': 'Failed to download ${task['type']}: ${task['fileName']}',
        });
        logMessage('Failed to download ${task['fileName']}: $e');
        await FileOperations.deleteFile(filePath);
        params.sendPort.send(results);
        results.clear();
      }
    }
    // params.sendPort.send(results);
  }

  Future<void> deleteOldFiles(
      {Duration maxAge = const Duration(minutes: 5)}) async {
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      logMessage('Storage permission not granted');
    } else {
      final directoryPath = await FileOperations.getApplicationDirectoryPath();
      final receivePort = ReceivePort();
      Isolate.spawn(FileOperations.deleteOldFilesIsolate,
          DeleteParams(receivePort.sendPort, directoryPath));
      await receivePort.first;
      logMessage('Old files deleted');
    }
  }

  Future<void> startMultipleAssetDownload(List<ResourceItem>? assets) async {
    if (kDebugMode) {
      print('Initializing downloads');
    }
    downloadResourceItems(assets, (map) {});
    if (kDebugMode) {
      print('Downloads initialized');
    }
  }
}

class DownloadParams {
  final SendPort sendPort;
  final List<Map<String, String>> downloadTasks;
  final Duration downloadDelay;

  DownloadParams(this.sendPort, this.downloadTasks, this.downloadDelay);
}
