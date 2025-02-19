import 'package:flutter/widgets.dart';
import 'package:zinc/domain/bff/ui_configuration/ui_component_models.dart';

class HeaderComponentWidget extends StatelessWidget {
  final HeaderComponent headerComponent;

  HeaderComponentWidget(this.headerComponent);

  @override
  Widget build(BuildContext context) {
    return Text("Header: ${headerComponent.defaultCurrency}");
  }
}
