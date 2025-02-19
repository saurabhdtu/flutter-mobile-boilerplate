import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zinc/core/config_driven_ui/ui/components/banner_component.dart';
import 'package:zinc/core/config_driven_ui/ui/components/bottom_component.dart';
import 'package:zinc/core/config_driven_ui/ui/components/bottom_navigation_component.dart';
import 'package:zinc/core/config_driven_ui/ui/components/card_component.dart';
import 'package:zinc/core/config_driven_ui/ui/components/crousel_component.dart';
import 'package:zinc/core/config_driven_ui/ui/components/date_time_component.dart';
import 'package:zinc/core/config_driven_ui/ui/components/drop_down_component.dart';
import 'package:zinc/core/config_driven_ui/ui/components/file_upload_component.dart';
import 'package:zinc/core/config_driven_ui/ui/components/grid_component.dart';
import 'package:zinc/core/config_driven_ui/ui/components/header_component.dart';
import 'package:zinc/core/config_driven_ui/ui/components/list_view_horizontal.dart';
import 'package:zinc/core/config_driven_ui/ui/components/media_component.dart';
import 'package:zinc/core/config_driven_ui/ui/components/module_component.dart';
import 'package:zinc/core/config_driven_ui/ui/components/text_component.dart';
import 'package:zinc/core/config_driven_ui/ui/components/text_input_component.dart';
import 'package:zinc/domain/bff/ui_configuration/ui_component_models.dart';
import 'package:zinc/lob/airwallex/common/ui/zinc_file_upload/zinc_file_upload_bloc.dart';

extension ConfiguratedHomeUiWidgets on UiComponent? {
  Widget getWidget({GlobalKey<FormState>? formKey}) {
    if (this == null) return const SizedBox.shrink();
    switch (this.runtimeType) {
      case TextComponent:
        return TextComponentWidget(textComponents: [this as TextComponent]);
      case ButtonComponent:
        return ButtonComponentWidget(
          this as ButtonComponent,
          formKey: formKey,
        );
      case BottomNavigationComponent:
        return BottomNavigationWidget(
          this as BottomNavigationComponent,
        );
      case HeaderComponent:
        return HeaderComponentWidget(this as HeaderComponent);
      case MediaComponent:
        return MediaComponentWidget(this as MediaComponent);
      case HorizontalListComponent:
        return HorizontalListWidget(this as HorizontalListComponent);
      case BannerComponent:
        return BannerComponentWidget(this as BannerComponent);
      case CardComponent:
        return CardComponentWidget(this as CardComponent);
      case GridComponent:
        return GridComponentWidget(this as GridComponent);
      case CarouselComponent:
        return CarouselComponentWidget(this as CarouselComponent);
      case DatePickerComponent:
        return DatePickerComponentWidget(this as DatePickerComponent);
      case DropdownComponent:
        return DropDownComponentWidget(this as DropdownComponent);
      case FileUploadComponent:
        return BlocProvider(
            create: (context) => ZincFileUploadBloc(),
            child: FileUploadComponentWidget(this as FileUploadComponent));
      case TextInputComponent:
        return TextInputComponentWidget(this as TextInputComponent);

      case ModuleComponent:
        return ModuleComponentWidget(this as ModuleComponent);
    }
    return const SizedBox.shrink();
  }
}
