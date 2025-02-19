import 'package:design_module/resources/zinc_style_colors.dart';
import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:design_module/widget/zinc_button.dart';
import 'package:flutter/material.dart';

abstract class ZincDraggableBottomSheet {
  static Future<void> showDraggableSheet({
    required BuildContext context,
    bool isDismissible = true,
    String cta = "",
    final String? title,
    final String? description,
    required Widget child,
    final ZincButton? bottomButton,
    final Color? bottomSheetBgColor,
    final Color? dragPillColor,
    final TextStyle? titleStyle,
    final TextStyle? descriptionStyle,
  }) {
    final DraggableScrollableController sheetController =
        DraggableScrollableController();
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible,
      isScrollControlled: true,
      builder: (context) => Stack(
        children: [
          DraggableScrollableSheet(
            controller: sheetController,
            initialChildSize: 0.5,
            maxChildSize: 1,
            expand: false,
            builder: (context, scrollController) {
              return CustomScrollView(
                physics: const ClampingScrollPhysics(),
                controller: scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: dragPillColor ?? GreyscaleSurface().subtle,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100)),
                        ),
                        height: 4,
                        width: 44,
                        margin: const EdgeInsets.only(bottom: 8),
                      ),
                    ),
                  ),
                  SliverList.list(
                    children: [
                      Container(
                        height: 24,
                        decoration: BoxDecoration(
                          color: bottomSheetBgColor ?? GreyscaleSurface().white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                      ),
                      if (title != null || description != null)
                        Container(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                          decoration: BoxDecoration(
                            color:
                                bottomSheetBgColor ?? GreyscaleSurface().white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (title != null)
                                Text(
                                  title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: titleStyle ??
                                      const ZincTextStyle.superLargeExtraBold(),
                                ),
                              if (description != null)
                                Text(
                                  description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: descriptionStyle ??
                                      const ZincTextStyle.normalSemiBold()
                                          .copyWith(
                                        color: GreyscaleText().subtitle,
                                      ),
                                ),
                            ],
                          ),
                        ),
                    ],
                  ),

                  SliverList.list(
                    children: [
                      ...[child],
                    ],
                  ),

                  //bottomspacing for button so that it doesnt hides list items
                  SliverToBoxAdapter(
                    child: Container(
                      color: bottomSheetBgColor ?? GreyscaleSurface().white,
                      height: bottomButton != null
                          ? 80
                          : 40, //TODO: change values after button group component gets added
                    ),
                  ),
                ],
              );
            },
          ),
          if (bottomButton != null)
            Positioned(
              bottom: 0,
              left: 0,
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 20,
                        ),
                        width: MediaQuery.of(context).size.width,
                        color: bottomSheetBgColor ?? GreyscaleSurface().white,
                        child: bottomButton,
                      ),
                      Container(
                        color: bottomSheetBgColor ?? GreyscaleSurface().white,
                        height: 20,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

///USAGE:
///with textfield
// ZincTextInput(
//   rightIcon = const Icon(Icons.abc),
//   fieldController = _tempController,
//   placeholder = "placeholder",
//   label = "label",
//   inputState = TextInputState.normal,
//   dropDownWidget = ZincInputFieldDropDownButton(
//     selected: selectedText,
//     title: "title",
//     onTap: () {
//       ZincDraggableBottomSheet.showDraggableSheet(
//         context: context,
//         // title: "Title",
//         // description: "lorem ipsum doler sit amet.",
//         child: const TestWidgetDropDown(),
//         bottomButton: //optional, if you want a floating button, else pass it in your dropdownwidget
//             PrimaryZincButton.normal(title: "title"),
//       );
//     },
//   ),
// ),

