class AppConfig {
  final String baseUrl;
  final String mixpanelToken;
  final String moEngageId;
  final String hvAppId;
  final String hvApiKey;
  final String appsFlyerKey;
  final String appStoreid;
  String versionCode;
  String versionName;

  AppConfig(
      {required this.baseUrl,
      required this.mixpanelToken,
      required this.moEngageId,
      required this.hvAppId,
      required this.hvApiKey,
      required this.appStoreid,
      required this.versionCode,
      required this.versionName,
      required this.appsFlyerKey});

  // Factory method to create an AppConfig from a parsed JSON map
  factory AppConfig.fromJson(dynamic json) {
    return AppConfig(
        baseUrl: json['BASE_URL'] as String,
        mixpanelToken: json['MIXPANEL_TOKEN'] as String,
        moEngageId: json['MOENGAGE_ID'] as String,
        hvAppId: json['HV_APP_ID'] as String,
        hvApiKey: json['HV_API_KEY'] as String,
        appsFlyerKey: json['apps_flyer_key'] as String,
        appStoreid: json['app_store_id'] as String,
        versionCode: '',
        versionName: '');
  }

  @override
  String toString() {
    return 'AppConfig(baseUrl: $baseUrl, mixpanelToken: $mixpanelToken, moEngageId: $moEngageId, hvAppId: $hvAppId, hvApiKey: $hvApiKey)';
  }

  bool get isDev =>
      baseUrl.contains("sandbox") ||
          baseUrl.contains("stage") ||
          baseUrl.contains("dev");
}
