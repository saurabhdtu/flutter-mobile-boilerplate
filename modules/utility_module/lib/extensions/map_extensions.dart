import 'dart:io';

import 'package:dio/dio.dart';
import 'package:share_plus/share_plus.dart';
import 'package:utility_module/extensions/string_extensions.dart';

extension MapExtensions on Map {
  bool hasKeyThatContains(String pattern) => keys.fold(
      false,
      (previousValue, element) =>
          previousValue || element.toString().contains(pattern));

  Future<FormData> getMultipartDataRequest(String fileType) async {
    List<MapEntry<String, dynamic>> entries = [];
    this.entries.forEach((e) async {
      if (e.value is File) {
        final filePath = (e.value as File).path;
        final mimeType = "image/${filePath.getExtension(fileType)}";
        final fileName = filePath.getFileName();
        final multipart = await MultipartFile.fromFile(filePath,
            contentType: DioMediaType.parse(mimeType), filename: fileName);
        entries.add(MapEntry<String, dynamic>(e.key.toString(), multipart));
      } else if (e.value is XFile) {
        final filePath = (e.value as XFile).path;
        final mimeType = "image/${filePath.getExtension(fileType)}";
        final fileName = filePath.getFileName();
        final multipart = await MultipartFile.fromFile(filePath,
            contentType: DioMediaType.parse(mimeType), filename: fileName);
        entries.add(MapEntry<String, dynamic>(e.key.toString(), multipart));
      } else if (e.value != null) {
        entries.add(MapEntry<String, dynamic>(e.key.toString(), e.value));
      }
    });

    return FormData.fromMap(Map.fromEntries(entries));
  }
}
