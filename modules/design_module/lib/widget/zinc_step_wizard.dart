import 'package:design_module/resources/zinc_style_colors.dart';
import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:flutter/material.dart';

enum ZincStepperState { half, full, empty }

class ZincStepperStep extends StatelessWidget {
  ZincStepperStep(
      {super.key,
      required this.index,
      required this.listLength,
      required this.currentStep,
      required this.label});

  final int index;
  final int listLength;
  int currentStep;
  final String? label;
  ZincStepperState getStepperState(int index, int currentStep) {
    if (index == currentStep) {
      return ZincStepperState.half;
    } else if (index < currentStep) {
      return ZincStepperState.full;
    } else {
      return ZincStepperState.empty;
    }
  }

  double containerWidth = 56;
  final Color inactiveIconColor = GreyscaleText().placeholder;
  final Color activeIconColor = PrimaryBorder().darker;
  final Color inactiveLineColor = GreyscaleSurface().disabled;
  final Color activeLineColor = PrimarySurface().darker;

  @override
  Widget build(BuildContext context) {
    ZincStepperState stepperState = getStepperState(index, currentStep);
    return Column(
      children: [
        SizedBox(
          width: containerWidth,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  color: index == 0
                      ? Colors.transparent
                      : stepperState == ZincStepperState.half
                          ? activeLineColor
                          : stepperState == ZincStepperState.full
                              ? activeLineColor
                              : inactiveLineColor,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: stepperState == ZincStepperState.empty
                      ? inactiveIconColor
                      : activeIconColor,
                ),
                child: stepperState == ZincStepperState.full
                    ? Icon(
                        Icons.done,
                        size: 8,
                        color: GreyscaleText().negative,
                      )
                    : const SizedBox(),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  color: index == (listLength - 1)
                      ? Colors.transparent
                      : stepperState == ZincStepperState.empty
                          ? inactiveLineColor
                          : activeLineColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: containerWidth,
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            label ?? "",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const ZincTextStyle.microBoldCaps().copyWith(
              height: (14 / 10),
              color: stepperState == ZincStepperState.half
                  ? PrimarySurface().darker
                  : stepperState == ZincStepperState.full
                      ? GreyscaleText().subtitle
                      : GreyscaleText().placeholder,
            ),
          ),
        ),
      ],
    );
  }
}

class ZincStepWizard extends StatelessWidget {
  const ZincStepWizard({super.key, required this.steps});
  final List<ZincStepperStep> steps;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...steps,
      ],
    );
  }
}
