import 'package:flutter/cupertino.dart';

class WidgetWithFooterContainer extends StatelessWidget {
  final Widget body;
  final Widget footer;
  final Alignment alignment;

  const WidgetWithFooterContainer(
      {required this.body,
      required this.footer,
      this.alignment = Alignment.bottomCenter});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: alignment, children: [Align(alignment:Alignment.topCenter,child: body), footer]);
  }
}
