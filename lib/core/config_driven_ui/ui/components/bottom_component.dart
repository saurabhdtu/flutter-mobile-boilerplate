import 'package:common_module/base/base_component_state.dart';
import 'package:design_module/widget/zinc_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:zinc/domain/bff/ui_configuration/ui_component_models.dart';

class ButtonComponentWidget extends StatelessWidget {
  final ButtonComponent buttonComponent;
  final GlobalKey<FormState>? formKey;

  ButtonComponentWidget(this.buttonComponent, {this.formKey});

  @override
  Widget build(BuildContext context) {
    return PrimaryZincButton.normal(
        title: buttonComponent.label?.value,
        titleStyle: buttonComponent.label?.textStyle
            ?.copyWith(color: buttonComponent.label?.color ?? Colors.white),
        bgColor: buttonComponent.backgroundColor,
        borderRadius: BorderRadius.circular(buttonComponent.cornerRadius),
        onTap: () {
          final form = formKey?.currentState;
          if (form != null) {
            if (form.validate()) {
              form.save();
              if (buttonComponent.action != null) {
                context
                    .findAncestorStateOfType<BaseComponentState>()
                    ?.onComponentClicked(buttonComponent.action!.action);
              }
            } else {
              // Handle validation errors
            }
          } else {
            print('Form.of(context) returned null');
          }
        });
  }
}
