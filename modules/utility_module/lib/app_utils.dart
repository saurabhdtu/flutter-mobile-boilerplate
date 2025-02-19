import 'dart:math';

import 'dart:io';

import 'package:fc_native_image_resize/fc_native_image_resize.dart';
import 'package:flutter/services.dart';
import 'package:utility_module/extensions/string_extensions.dart';
import 'package:utility_module/logger/logger.dart';
import 'package:utility_module/utitlity_constants.dart';

abstract class AppUtils {
  static void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  static Future<String?> resizeImageFile(String filePath) async {
    final existingFileSize = await (File(filePath).length());
    if (existingFileSize > UtilityConstants.oneMb) {
      final plugin = FcNativeImageResize();
      String fileName = filePath.getFileName();
      String compressedFilePath =
          filePath.replaceAll(fileName, "$fileName-small");
      try {
        /// Resizes the [srcFile] image with the given options and saves the results
        /// to [destFile].
        ///
        /// [srcFile] source image path.
        /// [srcFileUri] true if source image is a Uri (Android only).
        /// [destFile] destination image path.
        /// [width] destination image width.
        /// Pass -1 to adjust width based on height (keepAspectRatio must be true).
        /// [height] destination image height.
        /// Pass -1 to adjust height based on width (keepAspectRatio must be true).
        /// [keepAspectRatio] if true, keeps aspect ratio.
        /// [format] destination file format. 'png' or 'jpeg'.
        /// [quality] only applies to 'jpeg' type, 1-100 (100 best quality).
        await plugin.resizeFile(
            srcFile: filePath,
            destFile: compressedFilePath,
            width: 1920,
            height: -1,
            keepAspectRatio: true,
            format: 'jpeg',
            quality: 90);
        return compressedFilePath;
      } catch (err) {
        logMessage(err.toString());
        return null;
      }
    } else {
      return filePath;
    }
  }

  static String generateRandomWord({int wordLength = 4}){
    Random random = Random();
    String word = "";
    for(int i =0;i<wordLength;i++){
      word+=String.fromCharCode(random.nextInt(26)+65);
    }
    return word;
  }
}
