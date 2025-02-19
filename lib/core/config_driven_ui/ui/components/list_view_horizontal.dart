import 'package:flutter/widgets.dart';
import 'package:zinc/core/config_driven_ui/ui/ui_component_creator.dart';
import 'package:zinc/domain/bff/ui_configuration/ui_component_models.dart';

class HorizontalListWidget extends StatelessWidget {
  final HorizontalListComponent horizontalListComponent;

  HorizontalListWidget(this.horizontalListComponent);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      width: double.infinity,
      child: ListView.separated(
          itemBuilder: (context, index) {
            return horizontalListComponent.children[index].getWidget();
          },
          separatorBuilder: (context, index) {
            return const SizedBox(width: 12.0);
          },
          itemCount: horizontalListComponent.children.length),
    );
  }
}
