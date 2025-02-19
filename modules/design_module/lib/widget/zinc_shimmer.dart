import 'package:design_module/resources/zinc_style_colors.dart';
import 'package:design_module/widget/zinc_rounded_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget getShimmerListViewLoader(
        {double bottom = 0.0,
        double top = 0.0,
        int listItemsCount = 3,
        double mLeft = 20.0,
        double mRight = 20.0,
        bool isHeavy = false}) =>
    Container(
        margin: EdgeInsets.only(
            left: mLeft, right: mRight, bottom: bottom, top: top),
        child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 16,
                  );
                },
                shrinkWrap: true,
                itemBuilder: (context, index) => isHeavy
                    ? _getShimmerHeavyListViewItem()
                    : getShimmerListViewItem(),
                itemCount: listItemsCount)));

getShimmerListViewItem() => getRoundedBorderWidget(
    color: GreyscaleSurface().shimmer,
    radius: 4.0,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 45.0,
                width: 45.0,
                child: RoundedWidget(
                    radius: 20.0,
                    color: GreyscaleSurface().shimmer, //colorF8F7FC,
                    child: getSimpleShimmerView(22, 22)),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 14.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getSimpleShimmerView(200, 12),
                      const SizedBox(
                        height: 12,
                      ),
                      getSimpleShimmerView(120, 8)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ));

_getShimmerHeavyListViewItem() => getRoundedBorderWidget(
      color: GreyscaleSurface().shimmer,
      radius: 4.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        child: Container(
          color: GreyscaleSurface().white,
          height: 120.0,
          child: const SizedBox.shrink(),
        ),
      ),
    );

Widget getSimpleShimmerView(double width, double height) => Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(2.0)))));
