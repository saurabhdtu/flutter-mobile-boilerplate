import 'package:design_module/constants.dart';
import 'package:flutter/material.dart';
import 'package:zinc/core/config_driven_ui/ui/components/text_component.dart';
import 'package:zinc/domain/bff/ui_configuration/ui_component_models.dart';

class CardComponentWidget extends StatelessWidget {
  final CardComponent cardComponent;

  CardComponentWidget(this.cardComponent);

  @override
  Widget build(BuildContext context) {
    switch (cardComponent.cardType) {
      case null:
        return const SizedBox.shrink();
      case CardType.small:
        return Container(
            padding: const EdgeInsets.all(8.0),
            height: 50.0,
            child: Column(
              children: [
                TextComponentWidget(textComponents: cardComponent.title ?? []),
                const SizedBox(height: 8.0),
                TextComponentWidget(
                    textComponents: cardComponent.description ?? []),
              ],
            ));
      case CardType.medium:
        return Container(
          padding: const EdgeInsets.all(12.0),
          height: 80.0,
          child: Column(
            children: [
              TextComponentWidget(textComponents: cardComponent.title ?? []),
              const SizedBox(height: 8.0),
              TextComponentWidget(
                  textComponents: cardComponent.description ?? []),
            ],
          ),
        );
      case CardType.large:
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: 140.0,
          child: Column(
            children: [
              TextComponentWidget(textComponents: cardComponent.title ?? []),
              const SizedBox(height: 8.0),
              TextComponentWidget(
                  textComponents: cardComponent.description ?? []),
            ],
          ),
        );
    }
  }
}
