import 'package:flutter/widgets.dart';
import 'package:zinc/domain/bff/ui_configuration/ui_component_models.dart';

class TextComponentWidget extends StatelessWidget {
  final List<TextComponent> textComponents;

  const TextComponentWidget({
    Key? key,
    required this.textComponents,
  })  : assert(textComponents.length > 0, 'textComponents cannot be empty'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: textComponents
            .map(
              (e) => TextSpan(
                text: e.value,
                style: e.textStyle,
              ),
            )
            .toList(),
      ),
    );
  }
}
