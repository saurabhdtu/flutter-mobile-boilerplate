import 'package:flutter/material.dart';
import 'package:zinc/core/config_driven_ui/ui/ui_component_creator.dart';
import 'package:zinc/domain/bff/ui_configuration/onboarding_config_models.dart';

final GlobalKey<FormState> configFormKey = new GlobalKey<FormState>();

class PageConfigForm extends StatefulWidget {
  final PageConfig? pageConfig;
  final bool launchForResult;
  const PageConfigForm({Key? key, required this.pageConfig, this.launchForResult = false}) : super(key: key);

  @override
  _PageConfigFormState createState() => _PageConfigFormState();
}

class _PageConfigFormState extends State<PageConfigForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: configFormKey,
      child: Builder(
        builder: (context) {
          return ListView.separated(
            itemCount: widget.pageConfig?.body.length ?? 0,
            itemBuilder: (context, index) {
              final uiComponent = widget.pageConfig?.body[index];
              return uiComponent?.getWidget(formKey: configFormKey);
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 12.0),
          );
        },
      ),
    );
  }
}
