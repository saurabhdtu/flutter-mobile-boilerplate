import 'dart:io';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

abstract class FileOperations {

  ///&check FileName file exists or Not
  static Future<bool> checkGivenFileNameFileExistsOrNot(String? fileName) async {
    final directoryPath = await getApplicationDirectoryPath();
    final filePath = '$directoryPath/$fileName';
    final exists = await checkFileExists(filePath);
    return exists;
  }

  ///*get directory filepath with filename
  static Future<String> getDirectoryFilePathForFileName(String? fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    return filePath;
  }

  ///*get the directory path*/
  static Future<String> getApplicationDirectoryPath() async {
    final directory = await getApplicationDocumentsDirectory();
    if (kDebugMode) {
      print('Application directory path: ${directory.path}');
    }
    return directory.path;
  }

  static Future<File> writeBytesToTemporaryPngFile(List<int> bytes) async {
    // Get the temporary directory path
    Directory tempDir = await getTemporaryDirectory();

    // Define the path to the temporary PNG file
    String tempPath = '${tempDir.path}/temp_aadhar_image.png';

    // Create the file and write the bytes
    File tempFile = File(tempPath);
    return await tempFile.writeAsBytes(bytes);
  }

  ///*file exists or not*/
  static Future<bool> checkFileExists(String filePath) async {
    final exists = File(filePath).existsSync();
    if (kDebugMode) {
      print('Checking if file exists ($filePath): $exists');
    }
    return exists;
  }

  ///*create new file*/
  static Future<File> createNewFile(String filePath) async {
    final file = File(filePath);
    if (!file.existsSync()) {
      await file.create(recursive: true);
      if (kDebugMode) {
        print('Created new file: $filePath');
      }
    }
    return file;
  }

  ///*delete file*/
  static Future<void> deleteFile(String filePath) async {
    final file = File(filePath);
    if (file.existsSync()) {
      await file.delete();
      if (kDebugMode) {
        print('Deleted file: $filePath');
      }
    }
  }

  /// delete files under app directory on background
  ///* using isolate
  static Future<void> deleteOldFiles(
      String directoryPath, SendPort sendPort) async {
    final directory = Directory(directoryPath);
    directory.listSync().forEach((file) {
      try {
        file.deleteSync();
        if (kDebugMode) {
          print('Deleted old file: ${file.path}');
        }
      } catch (e) {
        if (kDebugMode) {
          print('Failed to delete old file: ${file.path}, Error: $e');
        }
      }
    });
    sendPort.send(null);
  }

  static void deleteOldFilesIsolate(DeleteParams params) {
    deleteOldFiles(params.directoryPath, params.sendPort);
  }
}

class DeleteParams {
  final SendPort sendPort;
  final String directoryPath;

  DeleteParams(this.sendPort, this.directoryPath);
}
