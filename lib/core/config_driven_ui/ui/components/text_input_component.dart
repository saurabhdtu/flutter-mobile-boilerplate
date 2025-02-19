import 'package:design_module/old_design/widget/custom_floating_text_field.dart';
import 'package:flutter/material.dart';
import 'package:utility_module/text_formatter.dart';
import 'package:zinc/core/config_driven_ui/ui/ui_component_creator.dart';
import 'package:zinc/domain/bff/ui_configuration/ui_component_models.dart';

class TextInputComponentWidget extends StatefulWidget {
  final TextInputComponent textInputComponent;

  TextInputComponentWidget(this.textInputComponent);

  @override
  State<StatefulWidget> createState() => _TextInputComponentState();
}

class _TextInputComponentState extends State<TextInputComponentWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: widget.textInputComponent.defaultValue?.value);
  }

  @override
  Widget build(BuildContext context) {
    return CustomFloatingTextField(
        textCapitalization: widget.textInputComponent.textCapitalization,
        controller: _controller,
        textStyle: widget.textInputComponent.defaultValue?.textStyle,
        hintStyle: widget.textInputComponent.hint?.textStyle,
        hintText: widget.textInputComponent.hint?.value,
        obscureText: widget.textInputComponent.isMasked,
        labelStyle: widget.textInputComponent.label?.textStyle,
        labelText: widget.textInputComponent.label?.value,
        onChanged: (text) {
          widget.textInputComponent.defaultValue?.value = text;
        },
        maxLength: widget.textInputComponent.maxLength,
        prefix: widget.textInputComponent.iconStart != null
            ? widget.textInputComponent.iconStart?.getWidget()
            : null,
        suffix: widget.textInputComponent.iconEnd?.getWidget(),
        maxLines: widget.textInputComponent.maxLines,
        textInputType: widget.textInputComponent.inputType,
        inputFormatters: widget.textInputComponent.filterTextInput
            ? [
                TextInputFormatterWithRegex(
                    "${widget.textInputComponent.validationRegex}")
              ]
            : [],
        validator: widget.textInputComponent.validationRegex != null
            ? (value) {
                if (!RegExp(widget.textInputComponent.validationRegex ?? "")
                    .hasMatch(value ?? "")) {
                  return "Enter a valid ${widget.textInputComponent.label?.value.toLowerCase() ?? "input"}";
                }
                return null;
              }
            : null);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
