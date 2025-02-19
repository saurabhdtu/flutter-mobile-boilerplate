import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:resource_download_manager_module/file_operations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([Directory])
void main() {
  // Define the MethodChannel used by path_provider
  const MethodChannel channel = MethodChannel('plugins.flutter.io/path_provider');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    // Set up a mock handler for the method channel
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getApplicationDocumentsDirectory') {
        // Return a temporary directory path
        return '/tmp';
      }
      return null;
    });
  });

  tearDown(() {
    // Remove the mock handler after the test
    channel.setMockMethodCallHandler(null);
  });

  group('FileOperations', () {
    test('checkGivenFileNameFileExistsOrNot returns true if file exists', () async {
      const fileName = 'test.txt';
      final directoryPath = await FileOperations.getApplicationDirectoryPath();
      final filePath = '$directoryPath/$fileName';
      await File(filePath).create(); // Creating the file for testing.

      final result = await FileOperations.checkGivenFileNameFileExistsOrNot(fileName);

      expect(result, true);

      await File(filePath).delete();
    });

    test('checkGivenFileNameFileExistsOrNot returns false if file does not exist', () async {
      final result = await FileOperations.checkGivenFileNameFileExistsOrNot('nonexistent.txt');

      expect(result, false);
    });

    test('createNewFile creates the file successfully', () async {
      final directoryPath = await FileOperations.getApplicationDirectoryPath();
      final filePath = '$directoryPath/test_create.txt';
      expect(await FileOperations.checkFileExists(filePath), false);
      final file = await FileOperations.createNewFile(filePath);
      expect(await file.exists(), true);
      await file.delete();
    });

    test('deleteFile deletes the file if it exists', () async {
      final directoryPath = await FileOperations.getApplicationDirectoryPath();
      final filePath = '$directoryPath/test_delete.txt';
      final file = await File(filePath).create();
      expect(await file.exists(), true);
      await FileOperations.deleteFile(filePath);
      expect(await file.exists(), false);
    });
  });
}
