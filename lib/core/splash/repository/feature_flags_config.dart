class FeatureFlagConfig {
  FeatureFlagConfig({
    Feature? remittance,
    Feature? airwallex,
  }) {
    _remittance = remittance;
    _airwallex = airwallex;
  }

  FeatureFlagConfig.fromJson(dynamic json) {
    _remittance = json['remittance'] != null
        ? Feature.fromJson(json['remittance'])
        : null;
    _airwallex = json['airwallex'] != null
        ? Feature.fromJson(json['airwallex'])
        : null;
  }

  Feature? _remittance;
  Feature? _airwallex;

  Feature? get remittance => _remittance;
  Feature? get airwallex => _airwallex;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_remittance != null) {
      map['remittance'] = _remittance?.toJson();
    }
    if (_airwallex != null) {
      map['airwallex'] = _airwallex?.toJson();
    }
    return map;
  }
}

class Feature {
  Feature({
    bool? enabled,
    Map<String, Feature>? subFeatures,
  }) {
    _enabled = enabled;
    _subFeatures = subFeatures ?? {};
  }

  Feature.fromJson(dynamic json) {
    _enabled = json['enabled'];
    if (json['subFeatures'] != null) {
      json['subFeatures'].forEach((key, value) {
        _subFeatures?[key] = Feature.fromJson(value);
      });
    }
  }

  bool? _enabled;
  Map<String, Feature>? _subFeatures;

  bool? get enabled => _enabled;
  Map<String, Feature>? get subFeatures => _subFeatures;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enabled'] = _enabled;
    if (_subFeatures != null) {
      map['subFeatures'] = _subFeatures?.map((key, value) => MapEntry(key, value.toJson()));
    }
    return map;
  }
}