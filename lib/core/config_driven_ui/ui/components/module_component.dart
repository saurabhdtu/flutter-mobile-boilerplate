import 'package:design_module/constants.dart';
import 'package:design_module/old_design/common_ui/dotted_border.dart';
import 'package:design_module/resources/dimens.dart';
import 'package:design_module/resources/zinc_style_colors.dart';
import 'package:design_module/widget/zinc_image.dart';
import 'package:flutter/material.dart';
import 'package:zinc/core/config_driven_ui/ui/page_config_creator.dart';
import 'package:zinc/core/config_driven_ui/ui/ui_component_creator.dart';
import 'package:zinc/domain/bff/ui_configuration/ui_component_models.dart';

class ModuleComponentWidget extends StatefulWidget {
  final ModuleComponent moduleComponent;

  ModuleComponentWidget(this.moduleComponent);

  @override
  State<StatefulWidget> createState() => _ModuleComponentState();
}

class _ModuleComponentState extends State<ModuleComponentWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bool refresh = false;
        switch (widget.moduleComponent.config?.type) {
          case PageType.emailVerification:
          case PageType.aadharVerification:
          case PageType.passportVerification:
            final result = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => widget.moduleComponent.config!.getWidget(
                  launchForResult: true,
                  metaData: widget.moduleComponent.config?.metaData),
            ));
            if (result is Map) {
              refresh = true;
              widget.moduleComponent.fieldValue = result;
            }
            break;
          case PageType.form:
          default:
        }
        if (refresh) setState(() {});
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: AppDimens.itemSpacing),
        color: GreyscaleSurface().lighter,
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(12),
          dashPattern: const [6, 6],
          color: Colors.grey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    widget.moduleComponent.fieldValue != null
                        ? ZincImage.imageAsset(
                            imageName: "img_checkbox.png",
                            isCircle: true,
                            borderRadius: 24,
                          )
                        : widget.moduleComponent.icon?.getWidget() ??
                            ZincImage.imageAsset(
                                imageName: "img_upload.svg",
                                isCircle: true,
                                imageWidth: 48,
                                imageHeight: 48),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: widget.moduleComponent.label?.getWidget() ??
                            const SizedBox.shrink())
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
