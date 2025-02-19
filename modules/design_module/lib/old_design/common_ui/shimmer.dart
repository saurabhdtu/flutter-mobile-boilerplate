import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:design_module/old_design/resources/color_manager.dart';
import 'package:design_module/resources/dimens.dart';

abstract class AppShimmer {
  static Widget verticalShimmerLoader(BuildContext context, {int? boxLimit}) {
    final height = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).viewPadding.bottom +
            MediaQuery.of(context).viewPadding.top);
    List<Widget> shimmers = [];
    for (int i = 0;
        i <
            (boxLimit ??
                ((height / (100 + (AppDimens.screenVerticalPadding * 2))) - 1)
                    .floor());
        i++) {
      shimmers.add(_verticalShimmerCard(context));
    }
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: shimmers),
    );
  }

  static Widget horizontalShimmerLoader(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      _horizontalShimmerCard(context),
      _horizontalShimmerCard(context)
    ]);
  }

  static _horizontalShimmerCard(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Shimmer.fromColors(
          baseColor: ColorManager.colorE8E8E8,
          highlightColor: ColorManager.colorD1D1D1,
          child: Container(
              height: 100, width: (width / 2) - 40, color: Colors.white)),
    );
  }

  static _verticalShimmerCard(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(
            AppDimens.homeScreenHorizontalMargin,
            AppDimens.screenVerticalPadding * 2,
            AppDimens.homeScreenHorizontalMargin,
            0),
        child: Shimmer.fromColors(
            baseColor: ColorManager.colorE8E8E8,
            highlightColor: ColorManager.colorD1D1D1,
            child: Container(
                height: 100, width: double.infinity, color: Colors.white)));
  }
}
