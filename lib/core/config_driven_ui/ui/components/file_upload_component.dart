import 'dart:io';

import 'package:design_module/old_design/common_ui/bottomsheet.dart';
import 'package:design_module/old_design/common_ui/dotted_border.dart';
import 'package:design_module/old_design/resources/theme_helper.dart';
import 'package:design_module/old_design/widget/custom_icon_button.dart';
import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:design_module/widget/zinc_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zinc/core/config_driven_ui/ui/ui_component_creator.dart';
import 'package:zinc/domain/bff/ui_configuration/ui_component_models.dart';
import 'package:zinc/lob/airwallex/common/ui/zinc_file_upload/zinc_file_upload_bloc.dart';

class FileUploadComponentWidget extends StatefulWidget {
  final FileUploadComponent fileUploadComponent;

  FileUploadComponentWidget(this.fileUploadComponent);

  @override
  State<StatefulWidget> createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUploadComponentWidget> {
  late ZincFileUploadBloc _fileUploadBloc;

  @override
  void initState() {
    super.initState();
    _fileUploadBloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.fileUploadComponent.launchModes?.length == 1) {
          widget.fileUploadComponent.fieldValue = await _fileUploadBloc
              .pickFile(widget.fileUploadComponent.launchModes!.first);
          setState(() {});
        }
        if (((widget.fileUploadComponent.launchModes ?? []).length > 1)) {
          _showDropDown().then((onValue) {
            setState(() {});
          });
        }
      },
      child: ColoredBox(
        color: PrimaryColors().gray5002,
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
                    widget.fileUploadComponent.fieldValue != null
                        ? ZincImage.imageAsset(
                            imageName: "img_checkbox.png",
                            isCircle: true,
                            borderRadius: 24,
                          )
                        : widget.fileUploadComponent.icon?.getWidget() ??
                            CustomIconButton(
                              height: 48,
                              width: 48,
                              padding: const EdgeInsets.all(0),
                              decoration: IconButtonStyleHelper.fillDarkGrey,
                              child: ZincImage.iconAsset(
                                iconName: "img_upload.svg",
                              ),
                            ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: widget.fileUploadComponent.label?.getWidget() ??
                            const SizedBox.shrink())
                  ],
                ),
                if (widget.fileUploadComponent.fieldValue != null)
                  const SizedBox(height: 8),
                Row(
                  children: [
                    if (widget.fileUploadComponent.fieldValue != null)
                      _buildThumbnail(widget.fileUploadComponent.fieldValue!),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showDropDown() async {
    await ZincBottomSheet.showBottomSheet(
      context,
      enableDrag: true,
      Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: (widget.fileUploadComponent.launchModes ?? [])
                .map(
                  (o) => Material(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ColoredBox(
                        color: PrimaryColors().gray5002,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          dashPattern: const [6, 6],
                          color: Colors.grey,
                          child: ListTile(
                            contentPadding: EdgeInsets.all(10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            title: Text(
                              o.name,
                              style: ZincTextStyle.moderateBold(),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 22.0,
                            ),
                            onTap: () async {
                              widget.fileUploadComponent.fieldValue =
                                  await _fileUploadBloc.pickFile(o);
                              context
                                  .pop(widget.fileUploadComponent.fieldValue);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          )),
      title: widget.fileUploadComponent.label?.value ?? "",
    );
  }

  Widget _buildThumbnail(XFile imageFile) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
          image: DecorationImage(
            image: FileImage(File(imageFile.path)),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
