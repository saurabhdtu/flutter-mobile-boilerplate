import 'package:design_module/old_design/widget/custom_floating_text_field.dart';
import 'package:flutter/material.dart';
import 'package:zinc/core/config_driven_ui/ui/ui_component_creator.dart';
import 'package:zinc/domain/bff/ui_configuration/ui_component_models.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class DatePickerComponentWidget extends StatefulWidget {
  final DatePickerComponent datePickerComponent;

  DatePickerComponentWidget(this.datePickerComponent);

  @override
  State<StatefulWidget> createState() => DatePickerComponentState();
}

class DatePickerComponentState extends State<DatePickerComponentWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: widget.datePickerComponent.defaultValue?.value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          DateTime? pickedDate = await _selectDate(_controller);
          if (pickedDate != null) {
            _controller.text = DateFormat(widget.datePickerComponent.dateFormat)
                .format(pickedDate);
            widget.datePickerComponent.fieldValue = _controller.text;
          }
        },
        child: CustomFloatingTextField(
            controller: _controller,
            enabled: false,
            textStyle: widget.datePickerComponent.defaultValue?.textStyle,
            labelStyle: widget.datePickerComponent.label?.textStyle,
            labelText: widget.datePickerComponent.label?.value,
            onChanged: (text) {
              widget.datePickerComponent.fieldValue = text;
            },
            prefix: widget.datePickerComponent.iconStart?.getWidget()));
  }

  Future<DateTime?> _selectDate(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.fromMillisecondsSinceEpoch(min(
          DateTime.now().millisecondsSinceEpoch,
          widget.datePickerComponent.maxDate.millisecondsSinceEpoch)),
      firstDate: widget.datePickerComponent.minDate,
      lastDate: widget.datePickerComponent.maxDate,
    );
    return picked;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
