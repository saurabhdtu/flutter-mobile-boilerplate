import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:zinc/domain/bff/ui_configuration/onboarding_config_models.dart';
import 'package:zinc/domain/bff/ui_configuration/ui_component_models.dart';

void main() {
  group("testing design configuration", () {
    test("empty home configuration but all library components", () {
      final config = '''
{
    "library": [
        {
            "component_type": "media",
            "url": "",
            "aspect_ratio": 1.0,
            "media_type": "lottie",
            "route": ""
        },
        {
            "component_type": "text",
            "value": "",
            "color": null,
            "font_weight": 500,
            "font_size":  16
        },
        {
            "component_type": "button",
            "text": {
              "component_type": "text",
              "value": "Hello"
            },
            "route": "",
            "corner_radius": 20,
            "background_color": null
        },
        {
            "component_type": "card",
            "card_type": "small",
            "title": [],
            "description": [],
            "cta": {}
        },
        {
            "component_type": "banner",
            "size": "small",
            "title": [
                {
                    "component_type": "text",
                    "value": "",
                    "color": null,
                    "font_weight": 500,
                    "font_size":  16
                },
                {
                    "component_type": "text",
                    "value": "",
                    "color": null,
                    "font_weight": 500,
                    "font_size":  16
                }
            ],
            "description": [
                {
                    "component_type": "text",
                    "value": "",
                    "color": null,
                    "font_weight": 500,
                    "font_size":  16
                },
                {
                    "component_type": "text",
                    "value": "",
                    "color": null,
                    "font_weight": 500,
                    "font_size":  16
                }
            ],
            "media": {},
            "cta": {}
        },
        {
            "component_type": "grid",
            "columns": 2,
            "rows": 2,
            "children": []
        },
        {
            "component_type": "horizontal_list",
            "children": [
                {}
            ]
        },
        {
            "component_type": "profile_header",
            "zinc_icon": "light/dark",
            "profile_icon": ""
        },
        {
            "component_type": "header",
            "default_currency": ""
        },
        {
            "component_type": "bottom_navigation_tab",
            "icon": {},
            "label": "",
            "route": "",
            "active_color": null,
            "inactive_color": null
        },
        {
            "component_type": "bottom_navigation",
            "children": []
        }
    ],
    "home_configuration": [
        {
            "component_type": "header",
            "default_currency": "USD"
        },
        {
            "component_type": "bottom_navigation",
            "children": [
                {
                    "component_type": "bottom_navigation_tab",
                    "icon": {
                        "url": "ic_home.svg",
                        "media_type": "local_svg"
                    },
                    "label": "Home",
                    "route": "home",
                    "active_color": "#FAFAFA",
                    "inactive_color": "#000000"
                },
                {
                    "component_type": "bottom_navigation_tab",
                    "icon": {
                        "url": "ic_wallet.svg",
                        "media_type": "local_svg"
                    },
                    "label": "Wallet",
                    "route": "wallet",
                    "active_color": "#FAFAFA",
                    "inactive_color": "#000000"
                },
                {
                    "component_type": "bottom_navigation_tab",
                    "icon": {
                        "url": "ic_send.svg",
                        "media_type": "local_svg"
                    },
                    "route": "home",
                    "active_color": "#FAFAFA",
                    "inactive_color": "#000000"
                },
                {
                    "component_type": "bottom_navigation_tab",
                    "icon": {
                        "url": "ic_card.svg",
                        "media_type": "local_svg"
                    },
                    "route": "home",
                    "label": "Card",
                    "active_color": "#FAFAFA",
                    "inactive_color": "#000000"
                },
                {
                    "component_type": "bottom_navigation_tab",
                    "icon": {
                        "url": "ic_hub.svg",
                        "media_type": "local_svg"
                    },
                    "route": "home",
                    "label": "Hub",
                    "active_color": "#FAFAFA",
                    "inactive_color": "#000000"
                }
            ]
        },
        {
            "component_type": "banner",
            "size": "small",
            "title": [
                {
                    "component_type": "text",
                    "value": "Zinc",
                    "color": "#DEDEDE",
                    "font_weight": 500,
                    "font_size": 16
                },
                {
                    "component_type": "text",
                    "value": "Money",
                    "color": "#000000",
                    "font_weight": 500,
                    "font_size": 16
                }
            ],
            "description": [
                {
                    "component_type": "text",
                    "value": "Send money abroad",
                    "color": "#DEDEDE",
                    "font_weight": 500,
                    "font_size": 12
                }
            ],
            "media": {
                "url": "",
                "media_type": "",
                "aspect_ratio": 1.0
            },
            "cta": {
              "component_type":"button",
                "text": {
                  "component_type":"text",
                  "value":"Banner action"
                },
                "route": "home",
                "corner_radius": 10
            }
        },
        {
            "component_type": "horizontal_list",
            "children": [
                {
                   "component_type": "banner",
                    "banner_type": "medium",
                    "title": [
                        {
                            "component_type": "text",
                            "value": "Zinc",
                            "color": "#DEDEDE",
                            "font_weight": 500,
                            "font_size": 16
                        },
                        {
                            "component_type": "text",
                            "value": "Money",
                            "color": "#000000",
                            "font_weight": 500,
                            "font_size": 16
                        }
                    ],
                    "description": [
                        {
                            "component_type": "text",
                            "value": "Send money abroad",
                            "color": "#DEDEDE",
                            "font_weight": 500,
                            "font_size": 12
                        }
                    ]
                },
                {
                    "component_type": "banner",
                    "banner_type": "medium",
                    "title": [
                        {
                            "component_type": "text",
                            "value": "Zinc",
                            "color": "#DEDEDE",
                            "font_weight": 500,
                            "font_size": 16
                        },
                        {
                            "component_type": "text",
                            "value": "Money",
                            "color": "#000000",
                            "font_weight": 500,
                            "font_size": 16
                        }
                    ],
                    "description": [
                        {
                            "component_type": "text",
                            "value": "Send money abroad",
                            "color": "#DEDEDE",
                            "font_weight": 500,
                            "font_size": 12
                        }
                    ]
                },
                {
                    "component_type": "banner",
                    "banner_type": "medium",
                    "title": [
                        {
                            "component_type": "text",
                            "value": "Zinc",
                            "color": "#DEDEDE",
                            "font_weight": 500,
                            "font_size": 16
                        },
                        {
                            "component_type": "text",
                            "value": "Money",
                            "color": "#000000",
                            "font_weight": 500,
                            "font_size": 16
                        }
                    ],
                    "description": [
                        {
                            "component_type": "text",
                            "value": "Send money abroad",
                            "color": "#DEDEDE",
                            "font_weight": 500,
                            "font_size": 12
                        }
                    ]
                }
            ]
        },
        {
            "component_type": "grid",
            "columns": 2,
            "rows": 2,
            "children": [
                {
                    "component_type": "card",
                    "card_type": "small",
                    "title": [
                        {
                            "text": "Label 1",
                            "font_weight": 500,
                            "font_size": 16
                        }
                    ]
                },
                {
                    "component_type": "card",
                    "card_type": "small",
                    "title": [
                        {
                            "text": "Label 2",
                            "font_weight": 500,
                            "font_size": 16
                        }
                    ]
                },
                {
                    "component_type": "card",
                    "card_type": "small",
                    "title": [
                        {
                            "text": "Label 3",
                            "font_weight": 500,
                            "font_size": 16
                        }
                    ]
                },
                {
                    "component_type": "card",
                    "card_type": "small",
                    "title": [
                        {
                            "text": "Label 4",
                            "font_weight": 500,
                            "font_size": 16
                        }
                    ]
                }
            ]
        }
    ]
}
      ''';
      final designConfig = UiConfigurationResponse.fromJson(jsonDecode(config));
      expect(designConfig.library?.components?.length, isNonZero);
      expect(designConfig.homeConfiguration.length, isNonZero);
      expect(designConfig.homeConfiguration.where((e)=> e is UnknownComponent).length, 0);
    });
  });
}
