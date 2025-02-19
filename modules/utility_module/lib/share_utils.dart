import 'package:share_plus/share_plus.dart';

class ShareUtils {
  static ShareUtils? _instance;

  static ShareUtils get getInstance => _instance ??= ShareUtils._();

  ShareUtils._();

  Future<ZincShareResult> shareTextContent(String message) async {
    return Future.value((await Share.share(message)).getResult());
  }

  Future<ZincShareResult> shareFileContent(List<String> files,
      {String message = ""}) async {
    return Future.value((await Share.shareXFiles(
            files.map((p) => XFile(p)).toList(),
            text: message))
        .getResult());
  }

  Future<ZincShareResult> sharUrlContent(Uri uri) async {
    return Future.value((await Share.shareUri(uri)).getResult());
  }
}

enum ZincShareResult { success, dismissed, unavailable }

extension ShareResultMapper on ShareResult {
  ZincShareResult getResult() {
    switch (this.status) {
      case ShareResultStatus.success:
        return ZincShareResult.success;
      case ShareResultStatus.dismissed:
        return ZincShareResult.dismissed;
      case ShareResultStatus.unavailable:
        return ZincShareResult.unavailable;
    }
  }
}
