import 'dart:ui';

import 'package:design_module/resources/zinc_style_colors.dart';
import 'package:design_module/widget/zinc_system_banner.dart';

Color getSnackBarBackgroundColor(ZincSnackbarType snackBarType) {
  switch (snackBarType) {
    case ZincSnackbarType.accent:
      return PrimarySurface().defaultC;
    case ZincSnackbarType.negative:
      return ErrorSurface().darker;
    case ZincSnackbarType.positive:
      return SuccessSurface().defaultC;
    case ZincSnackbarType.warning:
      return WarningSurface().defaultC;
    case ZincSnackbarType.neutral:
    default:
      return GreyscaleSurface().black;
  }
}
