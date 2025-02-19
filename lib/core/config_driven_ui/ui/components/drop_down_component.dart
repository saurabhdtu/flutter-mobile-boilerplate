import 'package:design_module/old_design/common_ui/bottomsheet.dart';
import 'package:design_module/old_design/widget/custom_floating_text_field.dart';
import 'package:design_module/resources/dimens.dart';
import 'package:design_module/widget/zinc_image.dart';
import 'package:design_module/widget/zinc_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:utility_module/extensions/list_extensions.dart';
import 'package:zinc/constants/strings.dart';
import 'package:zinc/domain/bff/ui_configuration/ui_component_models.dart';

class DropDownComponentWidget extends StatefulWidget {
  final DropdownComponent dropdownComponent;

  DropDownComponentWidget(this.dropdownComponent);

  @override
  State<StatefulWidget> createState() => _DropDownComponentState();
}

class _DropDownComponentState extends State<DropDownComponentWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: widget.dropdownComponent.defaultValue?.value);
    setValue();
  }

  void setValue() {
    if (widget.dropdownComponent.isMultiSelect)
      _controller.text = (widget.dropdownComponent.fieldValue ?? []).join(",");
    else
      _controller.text = widget.dropdownComponent.fieldValue ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          await _showDropDown();
          setValue();
        },
        child: CustomFloatingTextField(
            controller: _controller,
            textStyle: widget.dropdownComponent.defaultValue?.textStyle,
            labelStyle: widget.dropdownComponent.label?.textStyle,
            labelText: widget.dropdownComponent.label?.value,
            enabled: false,
            suffix: ZincImage.iconAsset(
              iconName: "ic_arrow_down.svg",
              isCircle: true,
              width: 24.0,
              height: 24.0,
            ),
            onChanged: (text) {
              widget.dropdownComponent.fieldValue = text;
            }));
  }

  Future<dynamic> _showDropDown() async {
    final map = Map.fromEntries(widget.dropdownComponent.options
            ?.map((e) => MapEntry<String, bool>(
                e, widget.dropdownComponent.fieldValue?.contains(e) ?? false))
            .toList() ??
        <MapEntry<String, bool>>[]);
    final selections = await ZincBottomSheet.showBottomSheet(context,
        enableDrag: true, Container(child: StatefulBuilder(
      builder: (context, setState) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: (widget.dropdownComponent.options ?? [])
                .map((o) => InkWell(
                      onTap: () {
                        if (!widget.dropdownComponent.isMultiSelect) {
                          final trueValues = map.entries
                              .where((e) => e.value == true)
                              .toList();
                          trueValues.forEach((e) => map[e.key] = false);
                        }
                        setState(() {
                          map[o] = !(map[o] ?? false);
                        });
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(child: Text(o)),
                              const SizedBox(width: 8.0),
                              ZincImage.flutterIcon(
                                  icon: map[o] == true
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_unchecked,
                                  size: 18.0,
                                  isCircle: false)
                            ],
                          )),
                    ) as Widget)
                .toList()
              ..add(PrimaryZincButton.normal(
                  onTap: () {
                    context.pop(map.entries.where((e) => e.value).toList());
                  },
                  margin: const EdgeInsets.symmetric(
                      vertical: AppDimens.screenVerticalPadding),
                  title: AppStrings.confirm)));
      },
    )),
        title: widget.dropdownComponent.label?.value ?? "",
        cta: AppStrings.confirm);
    final selected = selections is List<MapEntry<String, bool>>
        ? selections.map((e) => e.key).toList()
        : [];
    if (!selected.isEmptyOrNull()) {
      widget.dropdownComponent.fieldValue =
          widget.dropdownComponent.isMultiSelect ? selected : selected.first;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
