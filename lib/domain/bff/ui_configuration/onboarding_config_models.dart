import 'dart:math';

import 'package:design_module/constants.dart';
import 'package:design_module/ui_helper.dart';
import 'package:network_module/data/responses/responses.dart';
import 'package:utility_module/extensions/list_extensions.dart';
import 'package:utility_module/extensions/string_extensions.dart';
import 'package:zinc/domain/bff/ui_configuration/ui_component_models.dart';

class OnboardingConfigResponse extends BaseResponse {
  OnboardingConfigResponse.error(error) : super.error(error);

  OnboardingConfigResponse({
    String? id,
    String? submissionUrl,
    num? version,
    List<String>? steps,
    List<PageConfig>? config,
  }) {
    _id = id;
    _submissionUrl = submissionUrl;
    _version = version;
    _steps = steps;
    _config = config;
  }

  OnboardingConfigResponse.fromJson(dynamic json) {
    _id = json['id'];
    _submissionUrl = json['submission_url'];
    _version = json['version'];
    _steps = json['steps'] != null ? json['steps'].cast<String>() : [];
    if (json['config'] != null) {
      _config = [];
      json['config'].forEach((v) {
        _config?.add(PageConfig.fromJson(v));
      });
    }
  }

  String? _id;
  String? _submissionUrl;
  num? _version;
  List<String>? _steps;
  List<PageConfig>? _config;

  num? get version => _version;

  List<String>? get steps => _steps;

  List<PageConfig>? get config => _config;

  String? get submissionUrl => _submissionUrl;

  String? get id => _id;
}

class PageConfig {

  PageConfig.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _pageTitle = json['page_title'];
    _fieldKey = json['field_key'];
    _successAction = json['success_action'] != null
        ? UiComponentAction.fromJson(json['success_action'])
        : null;
    _footer =
        json['footer'] != null ? UiComponent.fromJson(json['footer']) : null;
    _header =
        json['header'] != null ? UiComponent.fromJson(json['header']) : null;
    if (json['body'] != null) {
      _body = [];
      json['body'].forEach((v) {
        _body?.add(UiComponent.fromJson(v));
      });
    }
  }

  UiComponentAction? _successAction;
  String? _id;
  String? _type;
  String? _pageTitle;
  UiComponent? _footer;
  UiComponent? _header;
  List<UiComponent>? _body;
  String? _fieldKey;
  dynamic fieldValue;
  dynamic metaData;

  UiComponentAction? get successAction => _successAction;

  String? get id => _id;

  PageType get type => UIWidgetHelper.instance.getPageType(_type);

  String? get pageTitle => _pageTitle;

  UiComponent? get footer => _footer;

  UiComponent? get header => _header;

  String get fieldKey => _fieldKey ?? _type ?? "key_${Random().nextInt(10)}";

  List<UiComponent> get body => _body ?? [];

  set body(List<UiComponent> body) {
    _body = body;
  }

  Map getKeyValueForForm() {
    Map m = {};
    if (!body.isEmptyOrNull()) {
      body.forEach((item) {
        if (!item.fieldKey.isEmptyOrNull()) {
          m[item.fieldKey.toString()] = item.fieldValue;
        }
      });
    }
    return m;
  }
}

class UiConfigurationResponse extends BaseResponse {
  UiConfigurationResponse.error(error) : super.error(error);

  UiConfigurationResponse({
    Library? library,
    List<UiComponent>? homeConfiguration,
  }) {
    _library = library;
    _homeConfiguration = homeConfiguration;
  }

  UiConfigurationResponse.fromJson(dynamic json) {
    _library =
        json['library'] != null ? Library.fromJson(json['library']) : null;
    _homeConfiguration = json['home_configuration'] != null
        ? (json['home_configuration'] as List)
            .map((e) => UiComponent.fromJson(e))
            .toList()
        : [];
  }

  Library? _library;
  List<UiComponent>? _homeConfiguration;

  Library? get library => _library;

  List<UiComponent> get homeConfiguration => _homeConfiguration ?? [];
}

class Library {
  Map<String, UiComponent>? components;

  Library.fromJson(dynamic json) {
    components = Map.fromEntries((json as List)
        .map((e) => MapEntry(
            (e as Map)["component_type"] as String, UiComponent.fromJson(e)))
        .toList());
  }
}
