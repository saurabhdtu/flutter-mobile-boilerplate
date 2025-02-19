import 'package:flutter/material.dart';
import 'package:zinc/core/config_driven_ui/ui/ui_component_creator.dart';
import 'package:zinc/domain/bff/ui_configuration/ui_component_models.dart';

class GridComponentWidget extends StatelessWidget {
  final GridComponent gridComponent;

  GridComponentWidget(this.gridComponent);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: gridComponent.rows * 100,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridComponent.columns.toInt(),
        ),
        children: gridComponent.children
            .map(
              (e) => e.getWidget(),
            )
            .toList(),
      ),
    );
  }
}
