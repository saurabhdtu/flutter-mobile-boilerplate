import 'package:design_module/constants.dart';
import 'package:design_module/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:utility_module/extensions/string_extensions.dart';
import 'package:zinc/domain/bff/ui_configuration/onboarding_config_models.dart';

abstract class UiComponent {
  String? componentType;
  String? fieldKey;
  dynamic fieldValue;
  dynamic metaData;
  bool? isMandatory;

  static UiComponent fromJson(dynamic json) {
    switch (json['component_type']) {
      case "media":
        return MediaComponent.fromJson(json);
      case "text":
        return TextComponent.fromJson(json);
      case "button":
        return ButtonComponent.fromJson(json);
      case "banner":
        return BannerComponent.fromJson(json);
      case "card":
        return CardComponent.fromJson(json);
      case "grid":
        return GridComponent.fromJson(json);
      case "carousel":
        return CarouselComponent.fromJson(json);
      case "horizontal_list":
        return HorizontalListComponent.fromJson(json);
      case "nav_bar":
        return NavBarComponent.fromJson(json);
      case "header":
        return HeaderComponent.fromJson(json);
      case "bottom_navigation":
        return BottomNavigationComponent.fromJson(json);
      case "text_input":
        return TextInputComponent.fromJson(json);
      case "dropdown":
        return DropdownComponent.fromJson(json);
      case "date_picker":
        return DatePickerComponent.fromJson(json);
      case "file_upload":
        return FileUploadComponent.fromJson(json);
      case "address_input":
        return AddressInputComponent.fromJson(json);
      case "module_as_page":
        return ModuleComponent.fromJson(json);
      default:
        return UnknownComponent();
    }
  }
}

class UnknownComponent extends UiComponent {}

class UiComponentAction {
  String? _action;
  String? _route;

  UiComponentAction.fromJson(dynamic json) {
    _action = json['action'];
    _route = json['route'];
  }

  String? get route => _route;

  ClickAction get action => UIWidgetHelper.instance.getClickAction(_action);
}

class BottomNavigationComponent extends UiComponent {
  BottomNavigationComponent.fromJson(dynamic json) {
    componentType = json['component_type'];
    if (json['children'] != null) {
      _children = [];
      json['children'].forEach((v) {
        _children?.add(BottomNavigationTab.fromJson(v));
      });
    }
  }

  List<BottomNavigationTab>? _children;

  List<BottomNavigationTab> get children => _children ?? [];
}

class HeaderComponent extends UiComponent {
  HeaderComponent.fromJson(dynamic json) {
    componentType = json['component_type'];
    _defaultCurrency = json['default_currency'];
  }

  String? _defaultCurrency;

  String? get defaultCurrency => _defaultCurrency;
}

class NavBarComponent extends UiComponent {
  NavBarComponent.fromJson(dynamic json) {
    componentType = json['component_type'];
    _zincIcon = json['zinc_icon'];
    _profileIcon = json['profile_icon'];
  }

  String? _zincIcon;
  String? _profileIcon;

  String? get zincIcon => _zincIcon;

  String? get profileIcon => _profileIcon;
}

class CarouselComponent extends UiComponent {
  CarouselComponent.fromJson(dynamic json) {
    componentType = json['component_type'];
    _showIndicator = json['show_indicator'];
    _aspectRatio = json['aspect_ratio'];
    if (json['children'] != null) {
      _children = [];
      json['children'].forEach((v) {
        _children?.add(UiComponent.fromJson(v));
      });
    }
  }

  bool get showIndicator => _showIndicator ?? false;
  List<UiComponent>? _children;
  num? _aspectRatio;
  bool? _showIndicator;

  double get aspectRatio => _aspectRatio?.toDouble() ?? 0;

  List<UiComponent> get children => _children ?? [];
}

class HorizontalListComponent extends UiComponent {
  HorizontalListComponent.fromJson(dynamic json) {
    componentType = json['component_type'];
    if (json['children'] != null) {
      _children = [];
      json['children'].forEach((v) {
        _children?.add(UiComponent.fromJson(v));
      });
    }
  }

  List<UiComponent>? _children;

  List<UiComponent> get children => _children ?? [];
}

class GridComponent extends UiComponent {
  GridComponent.fromJson(dynamic json) {
    componentType = json['component_type'];
    _columns = json['columns'];
    _rows = json['rows'];
    if (json['children'] != null) {
      _children = [];
      json['children'].forEach((v) {
        _children?.add(UiComponent.fromJson(v));
      });
    }
  }

  num? _columns;
  num? _rows;
  List<UiComponent>? _children;

  num get columns => _columns ?? 0;

  num get rows => _rows ?? 0;

  List<UiComponent> get children => _children ?? [];
}

class BannerComponent extends UiComponent {
  BannerComponent.fromJson(dynamic json) {
    componentType = json['component_type'];
    _bannerType =
        UIWidgetHelper.instance.getBannerType(json['banner_type']?.toString());
    if (json['title'] != null) {
      _title = [];
      json['title'].forEach((v) {
        _title?.add(TextComponent.fromJson(v));
      });
    }
    if (json['description'] != null) {
      _description = [];
      json['description'].forEach((v) {
        _description?.add(TextComponent.fromJson(v));
      });
    }
    _media =
        json['media'] != null ? MediaComponent.fromJson(json['media']) : null;
    _action = json['action'] != null
        ? UiComponentAction.fromJson(json['action'])
        : null;
  }

  BannerType? _bannerType;
  List<TextComponent>? _title;
  List<TextComponent>? _description;
  MediaComponent? _media;
  UiComponentAction? _action;

  BannerType? get bannerType => _bannerType;

  List<TextComponent> get title => _title ?? [];

  MediaComponent? get media => _media;

  UiComponentAction? get action => _action;

  List<TextComponent> get description => _description ?? [];
}

class CardComponent extends UiComponent {
  CardComponent.fromJson(dynamic json) {
    componentType = json['component_type'];
    _cardType =
        UIWidgetHelper.instance.getCardType(json["card_type"]?.toString());
    if (json['media'] != null) {
      _media = MediaComponent.fromJson(json['media']);
    }
    if (json['title'] != null) {
      _title = [];
      json['title'].forEach((v) {
        _title?.add(TextComponent.fromJson(v));
      });
    }
    if (json['description'] != null) {
      _description = [];
      json['description'].forEach((v) {
        _description?.add(TextComponent.fromJson(v));
      });
    }
    _action = json['action'] != null
        ? UiComponentAction.fromJson(json['action'])
        : null;
  }

  CardType? _cardType;
  MediaComponent? _media;
  List<TextComponent>? _title;
  List<TextComponent>? _description;
  UiComponentAction? _action;

  CardType? get cardType => _cardType;

  List<TextComponent>? get title => _title;

  List<TextComponent>? get description => _description;

  MediaComponent? get media => _media;

  UiComponentAction? get action => _action;
}

class ButtonComponent extends UiComponent {
  ButtonComponent.fromJson(dynamic json) {
    componentType = json['component_type'];
    _label =
        json['label'] != null ? TextComponent.fromJson(json['label']) : null;
    _cornerRadius = json['corner_radius'];
    _action = json['action'] != null
        ? UiComponentAction.fromJson(json['action'])
        : null;
    _leftIcon = json['left_icon'] != null
        ? MediaComponent.fromJson(json['left_icon'])
        : null;
    _backgroundColor =
        json['background_color']?.toString().colorFromHexString();
  }

  TextComponent? _label;
  MediaComponent? _leftIcon;
  UiComponentAction? _action;
  num? _cornerRadius;
  Color? _backgroundColor;

  MediaComponent? get leftIcon => _leftIcon;

  TextComponent? get label => _label;

  UiComponentAction? get action => _action;

  double get cornerRadius => _cornerRadius?.toDouble() ?? 0;

  Color? get backgroundColor => _backgroundColor;
}

class DatePickerComponent extends UiComponent {
  DatePickerComponent({
    String? componentType,
    String? dateFormat,
    TextComponent? label,
    MediaComponent? iconStart,
    int? maxDate,
    int? minDate,
    String? fieldKey,
    bool? isMandatory,
    TextComponent? defaultValue,
  }) {
    _componentType = componentType;
    _dateFormat = dateFormat;
    _label = label;
    _maxDate = maxDate;
    _minDate = minDate;
    this.fieldKey = fieldKey;
    _iconStart = iconStart;
    _isMandatory = isMandatory;
    _defaultValue = defaultValue;
  }

  DatePickerComponent.fromJson(dynamic json) {
    _componentType = json['component_type'];
    _dateFormat = json['date_format'];

    _label =
        json['label'] != null ? TextComponent.fromJson(json['label']) : null;
    _maxDate = json['max_date'];
    _minDate = json['min_date'];
    fieldKey = json['field_key'];
    _iconStart = json['icon_start'] != null
        ? MediaComponent.fromJson(json['icon_start'])
        : null;
    _isMandatory = json['is_mandatory'];
    _defaultValue = json['default_value'] != null
        ? TextComponent.fromJson(json['default_value'])
        : null;
  }

  String? _componentType;
  String? _dateFormat;
  TextComponent? _label;
  int? _maxDate;
  int? _minDate;
  bool? _isMandatory;
  MediaComponent? _iconStart;
  TextComponent? _defaultValue;

  MediaComponent? get iconStart => _iconStart;

  String? get componentType => _componentType;

  String get dateFormat => _dateFormat ?? "dd/MM/yyyy";

  TextComponent? get label => _label;

  DateTime get maxDate =>
      DateTime.now().add(Duration(milliseconds: _maxDate ?? 0));

  DateTime get minDate =>
      DateTime.now().add(Duration(milliseconds: _minDate ?? 0));

  bool get isMandatory => _isMandatory == true;

  TextComponent? get defaultValue => _defaultValue;
}

class TextInputComponent extends UiComponent {
  TextInputComponent({
    String? componentType,
    TextComponent? label,
    TextComponent? hint,
    TextComponent? defaultValue,
    String? validationRegex,
    String? inputType,
    String? textCapitalization,
    bool? isMasked,
    String? fieldKey,
    int? maxLines,
    bool? isMandatory,
    bool? filterTextInput,
    MediaComponent? iconLeft,
    MediaComponent? iconRight,
  }) {
    _componentType = componentType;
    _label = label;
    _hint = hint;
    _defaultValue = defaultValue;
    _validationRegex = validationRegex;
    _inputType = inputType;
    _textCapitalization = textCapitalization;
    _isMasked = isMasked;
    fieldKey = fieldKey;
    _maxLines = maxLines;
    _isMandatory = isMandatory;
    _iconStart = iconLeft;
    _filterTextInput = filterTextInput;
    _iconEnd = iconRight;
  }

  TextInputComponent.fromJson(dynamic json) {
    _componentType = json['component_type'];
    _label =
        json['label'] != null ? TextComponent.fromJson(json['label']) : null;
    _hint = json['hint'] != null ? TextComponent.fromJson(json['hint']) : null;
    _defaultValue = json['default_value'] != null
        ? TextComponent.fromJson(json['default_value'])
        : null;
    _validationRegex = json['validation_regex'];
    _inputType = json['input_type'];
    _textCapitalization = json['text_capitalization'];
    _isMasked = json['is_masked'];
    fieldKey = json['field_key'];
    _maxLength = json['max_length'];
    _maxLines = json['max_lines'];
    _isMandatory = json['is_mandatory'];
    _filterTextInput = json['filter_text_input'];
    _iconStart = json['icon_start'] != null
        ? MediaComponent.fromJson(json['icon_start'])
        : null;
    _iconEnd = json['icon_end'] != null
        ? MediaComponent.fromJson(json['icon_end'])
        : null;
  }

  String? _componentType;
  TextComponent? _label;
  TextComponent? _hint;
  TextComponent? _defaultValue;
  String? _validationRegex;
  String? _inputType;
  String? _textCapitalization;
  bool? _isMasked;
  bool? _filterTextInput;
  int? _maxLines;
  bool? _isMandatory;
  MediaComponent? _iconStart;
  MediaComponent? _iconEnd;
  int? _maxLength;

  bool get filterTextInput => _filterTextInput ?? false;

  String? get componentType => _componentType;

  TextComponent? get label => _label;

  TextComponent? get hint => _hint;

  TextComponent? get defaultValue => _defaultValue;

  String? get validationRegex => _validationRegex;

  TextInputType? get inputType =>
      UIWidgetHelper.instance.getTextInputType(_inputType);

  TextCapitalization? get textCapitalization =>
      UIWidgetHelper.instance.getTextCapitalization(_textCapitalization);

  bool get isMasked => _isMasked == true;

  int get maxLines => _maxLines ?? 1;

  bool get isMandatory => _isMandatory == true;

  MediaComponent? get iconStart => _iconStart;

  MediaComponent? get iconEnd => _iconEnd;

  int? get maxLength => _maxLength;
}

class TextComponent extends UiComponent {
  TextComponent.fromJson(dynamic json) {
    componentType = json['component_type'];
    _value = json['value'];
    _color = json['color']?.toString().colorFromHexString();
    _fontWeight = json['font_weight'];
    _fontSize = json['font_size'];
  }

  String? _value;
  Color? _color;
  int? _fontWeight;
  int? _fontSize;

  String get value => _value ?? "";

  set value(String? value) {
    _value = value;
  }

  Color? get color => _color;

  int? get fontWeight => _fontWeight;

  int? get fontSize => _fontSize;

  TextStyle? get textStyle =>
      UIWidgetHelper.instance.getTextStyle(fontWeight, fontSize, color);
}

class MediaComponent extends UiComponent {
  MediaComponent.fromJson(dynamic json) {
    componentType = json['component_type'];
    _url = json['url'];
    _tint = json['tint']?.toString().colorFromHexString();
    _aspectRatio = json['aspect_ratio'];
    _mediaType =
        UIWidgetHelper.instance.getMediaType(json['media_type']?.toString());
    _action = json['action'] != null
        ? UiComponentAction.fromJson(json['action'])
        : null;
  }

  String? _url;
  num? _aspectRatio;
  IllustrationType? _mediaType;
  UiComponentAction? _action;
  Color? _tint;

  String get url => _url ?? '';

  num? get aspectRatio => _aspectRatio;

  Color? get tint => _tint;

  IllustrationType? get mediaType => _mediaType;

  UiComponentAction? get action => _action;
}

class DropdownComponent extends UiComponent {
  DropdownComponent({
    String? componentType,
    TextComponent? defaultValue,
    bool? isMultiSelect,
    num? maxAllowedSelections,
    bool? isMandatory,
    TextComponent? label,
    String? fieldKey,
    List<String>? options,
  }) {
    _componentType = componentType;
    _defaultValue = defaultValue;
    _isMultiSelect = isMultiSelect;
    _maxAllowedSelections = maxAllowedSelections;
    _isMandatory = isMandatory;
    _label = label;
    this.fieldKey = fieldKey;
    _options = options;
  }

  DropdownComponent.fromJson(dynamic json) {
    _componentType = json['component_type'];
    _defaultValue = json['default_value'] != null
        ? TextComponent.fromJson(json['default_value'])
        : null;
    _isMultiSelect = json['is_multi_select'];
    _maxAllowedSelections = json['max_allowed_selections'];
    _isMandatory = json['is_mandatory'];
    _label =
        json['label'] != null ? TextComponent.fromJson(json['label']) : null;
    fieldKey = json['field_key'];
    _options = json['options'] != null ? json['options'].cast<String>() : [];
  }

  String? _componentType;
  TextComponent? _defaultValue;
  bool? _isMultiSelect;
  num? _maxAllowedSelections;
  bool? _isMandatory;
  TextComponent? _label;
  List<String>? _options;

  String? get componentType => _componentType;

  TextComponent? get defaultValue => _defaultValue;

  bool get isMultiSelect => _isMultiSelect ?? false;

  num? get maxAllowedSelections => _maxAllowedSelections;

  bool get isMandatory => _isMandatory == true;

  TextComponent? get label => _label;

  List<String>? get options => _options;
}

class FileUploadComponent extends UiComponent {
  FileUploadComponent({
    String? componentType,
    TextComponent? defaultValue,
    List<String>? launchModes,
    List<String>? allowedFileTypes,
    bool? isMandatory,
    TextComponent? label,
    MediaComponent? icon,
    String? fieldKey,
  }) {
    _componentType = componentType;
    _defaultValue = defaultValue;
    _launchModes = launchModes;
    _allowedFileTypes = allowedFileTypes;
    _isMandatory = isMandatory;
    _label = label;
    _icon = icon;
    this.fieldKey = fieldKey;
  }

  FileUploadComponent.fromJson(dynamic json) {
    _componentType = json['component_type'];
    _defaultValue = json['default_value'] != null
        ? TextComponent.fromJson(json['default_value'])
        : null;
    _launchModes = (json['launch_modes'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList();
    _allowedFileTypes = json['allowed_file_types'] != null
        ? json['allowed_file_types'].cast<String>()
        : [];
    _isMandatory = json['is_mandatory'];
    _label =
        json['label'] != null ? TextComponent.fromJson(json['label']) : null;
    _icon = json['icon'] != null ? MediaComponent.fromJson(json['icon']) : null;
    fieldKey = json['field_key'];
  }

  String? _componentType;
  TextComponent? _defaultValue;
  List<String>? _launchModes;
  List<String>? _allowedFileTypes;
  bool? _isMandatory;
  TextComponent? _label;
  MediaComponent? _icon;
  XFile? _selectedFile;

  String? get componentType => _componentType;

  TextComponent? get defaultValue => _defaultValue;

  List<FilePickerLaunchMode>? get launchModes => (_launchModes ?? [])
      .map((e) => UIWidgetHelper.instance.getFilePickerLaunchMode(e))
      .toList();

  List<String>? get allowedFileTypes => _allowedFileTypes;

  bool get isMandatory => _isMandatory == true;

  TextComponent? get label => _label;

  MediaComponent? get icon => _icon;
}

class BottomNavigationTab extends UiComponent {
  BottomNavigationTab.fromJson(dynamic json) {
    componentType = json['component_type'];
    _icon = json['icon'] != null ? MediaComponent.fromJson(json['icon']) : null;
    _label = json['label'];
    _activeColor = json['active_color']?.toString().colorFromHexString();
    _inactiveColor = json['inactive_color']?.toString().colorFromHexString();
    _action = json['action'] != null
        ? UiComponentAction.fromJson(json['action'])
        : null;
  }

  MediaComponent? _icon;
  String? _label;
  UiComponentAction? _action;
  Color? _activeColor;
  Color? _inactiveColor;

  MediaComponent? get icon => _icon;

  String? get label => _label;

  UiComponentAction? get action => _action;

  Color? get activeColor => _activeColor;

  Color? get inactiveColor => _inactiveColor;
}

class AddressInputComponent extends UiComponent {
  AddressInputComponent({
    String? componentType,
    bool? canCopyFromCurrentAddress,
    TextComponent? label,
    TextComponent? fieldStyle,
    bool? isMandatory,
    String? fieldKey,
    bool? prefillByPincodeEnabled,
    bool? editableFieldsByPincode,
  }) {
    _componentType = componentType;
    _canCopyFromCurrentAddress = canCopyFromCurrentAddress;
    _fieldStyle = fieldStyle;
    _label = label;
    _isMandatory = isMandatory;
    _fieldKey = fieldKey;
    _prefillByPincodeEnabled = prefillByPincodeEnabled;
    _editableFieldsByPincode = editableFieldsByPincode;
  }

  AddressInputComponent.fromJson(dynamic json) {
    _componentType = json['component_type'];
    _canCopyFromCurrentAddress = json['can_copy_from_current_address'];
    _label =
        json['label'] != null ? TextComponent.fromJson(json['label']) : null;
    _fieldStyle = json['field_style'] != null
        ? TextComponent.fromJson(json['field_style'])
        : null;
    _copyFromCurrentLabel = json['copy_from_current_label'] != null
        ? TextComponent.fromJson(json['copy_from_current_label'])
        : null;
    _isMandatory = json['is_mandatory'];
    _fieldKey = json['field_key'];
    _prefillByPincodeEnabled = json['prefill_by_pincode_enabled'];
    _editableFieldsByPincode = json['editable_fields_by_pincode'];
  }

  String? _componentType;
  bool? _canCopyFromCurrentAddress;
  TextComponent? _label;
  TextComponent? _fieldStyle;
  TextComponent? _copyFromCurrentLabel;
  bool? _isMandatory;
  String? _fieldKey;
  bool? _prefillByPincodeEnabled;
  bool? _editableFieldsByPincode;

  String? get componentType => _componentType;

  TextComponent? get label => _label;

  bool get canCopyFromCurrentAddress => _canCopyFromCurrentAddress == true;

  TextComponent? get copyFromCurrentLabel => _copyFromCurrentLabel;

  TextComponent? get fieldStyle => _fieldStyle;

  bool get isMandatory => _isMandatory == true;

  String? get fieldKey => _fieldKey;

  bool get prefillByPincodeEnabled => _prefillByPincodeEnabled == true;

  bool get editableFieldsByPincode => _editableFieldsByPincode == true;
}

class ModuleComponent extends UiComponent {
  ModuleComponent({
    String? componentType,
    PageConfig? config,
    TextComponent? label,
    bool? isMandatory,
    String? fieldKey,
    MediaComponent? icon,
  }) {
    _componentType = componentType;
    _config = config;
    _label = label;
    _isMandatory = isMandatory;
    _fieldKey = fieldKey;
    _icon = icon;
  }

  ModuleComponent.fromJson(dynamic json) {
    _componentType = json['component_type'];
    _config =
        json['config'] != null ? PageConfig.fromJson(json['config']) : null;
    _label =
        json['label'] != null ? TextComponent.fromJson(json['label']) : null;
    _isMandatory = json['is_mandatory'];
    _fieldKey = json['field_key'];
    _icon = json['icon'] != null ? MediaComponent.fromJson(json['icon']) : null;
  }

  String? _componentType;
  TextComponent? _label;
  PageConfig? _config;
  bool? _isMandatory;
  String? _fieldKey;
  MediaComponent? _icon;

  String? get componentType => _componentType;

  PageConfig? get config => _config;

  TextComponent? get label => _label;

  bool? get isMandatory => _isMandatory;

  String? get fieldKey => _fieldKey;

  MediaComponent? get icon => _icon;
}
