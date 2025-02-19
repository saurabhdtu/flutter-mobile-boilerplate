import 'dart:io';

class AppVersion {
  AppVersion(this.versionCode, this.versionNumber, this.minAppVersionNumber);

  AppVersion.fromJson(dynamic json) {
    versionCode = json['versionCode'] != null
        ? VersionCode.fromJson(json['versionCode'])
        : null;
    versionNumber = json['versionNumber'] != null
        ? VersionNumber.fromJson(json['versionNumber'])
        : null;
    minAppVersionNumber = json['minAppVersionNumber'] != null
        ? VersionNumber.fromJson(json['minAppVersionNumber'])
        : null;
    minAppVersionNumber = json['minAppVersionNumber'] != null
        ? VersionNumber.fromJson(json['minAppVersionNumber'])
        : null;
    appStoreUrls = json['appStoreUrls'] != null
        ? AppStoreUrls.fromJson(json['appStoreUrls'])
        : null;
  }

  VersionCode? versionCode;
  VersionNumber? versionNumber;
  VersionNumber? minAppVersionNumber;
  AppStoreUrls? appStoreUrls;
}

class VersionNumber {
  VersionNumber.fromJson(dynamic json) {
    _ios = json['ios'];
    _android = json['android'];
  }

  int? _ios;
  int? _android;

  int get versionNumber => (Platform.isAndroid ? _android : _ios) ?? 0;
}

class VersionCode {
  VersionCode.fromJson(dynamic json) {
    _ios = json['ios'];
    _android = json['android'];
  }

  String? _ios;
  String? _android;

  String get versionCode => (Platform.isAndroid ? _android : _ios) ?? "";
}

class AppStoreUrls {
  AppStoreUrls.fromJson(dynamic json) {
    _ios = json['ios'];
    _android = json['android'];
  }

  String? _ios;
  String? _android;

  String get storeUrl => (Platform.isAndroid ? _android : _ios) ?? "";
}
