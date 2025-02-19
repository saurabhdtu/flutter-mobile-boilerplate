import 'dart:ui';

import 'package:design_module/resources/zinc_colors.dart';

//abstract classes
abstract class Surface {
  Color get subtle;

  Color get lighter;

  Color get defaultC;

  Color get darker;

}

abstract class _Border {
  Color get subtle;

  Color get lighter;

  Color get defaultC;

  Color get darker;
}

abstract class TextIcon {
  Color get label;
}

//Extended classes

//Primary Surface
class PrimarySurface extends Surface {
  Color get heavyDarker => Color(0xFF124123);

  @override
  Color get darker => ZincColors.zincGreen.shade700;

  @override
  Color get defaultC => ZincColors.zincGreen.shade500;

  @override
  Color get lighter => ZincColors.zincGreen.shade200;

  @override
  Color get subtle => ZincColors.zincGreen.shade50;
}

//Primary Border
class PrimaryBorder extends _Border {
  @override
  Color get darker => ZincColors.zincGreen.shade700;

  @override
  Color get defaultC => ZincColors.zincGreen.shade500;

  @override
  Color get lighter => ZincColors.zincGreen.shade300;

  @override
  Color get subtle => ZincColors.zincGreen.shade100;
}

//Primary Text/Icon
class PrimaryTextIcon extends TextIcon {
  @override
  Color get label => ZincColors.zincGreen.shade700;
}

//Error Surface
class ErrorSurface extends Surface {
  @override
  Color get darker => ZincColors.zincImperialRed.shade700;

  @override
  Color get defaultC => ZincColors.zincImperialRed.shade500;

  @override
  Color get lighter => ZincColors.zincImperialRed.shade300;

  @override
  Color get subtle => ZincColors.zincImperialRed.shade100;
}

//Error Border
class ErrorBorder extends _Border {
  @override
  Color get darker => ZincColors.zincImperialRed.shade700;

  @override
  Color get defaultC => ZincColors.zincImperialRed.shade500;

  @override
  Color get lighter => ZincColors.zincImperialRed.shade300;

  @override
  Color get subtle => ZincColors.zincImperialRed.shade100;
}

//Error Text/Icon
class ErrorTextIcon extends TextIcon {
  @override
  Color get label => ZincColors.zincImperialRed.shade800;
}

//Success Surface
class SuccessSurface extends Surface {
  @override
  Color get darker => ZincColors.zincOliveGreen.shade800;

  @override
  Color get defaultC => ZincColors.zincOliveGreen.shade600;

  @override
  Color get lighter => ZincColors.zincOliveGreen.shade300;

  @override
  Color get subtle => ZincColors.zincOliveGreen.shade50;
}

//Success Border
class SuccessBorder extends _Border {
  @override
  Color get darker => ZincColors.zincOliveGreen.shade700;

  @override
  Color get defaultC => ZincColors.zincOliveGreen.shade500;

  @override
  Color get lighter => ZincColors.zincOliveGreen.shade300;

  @override
  Color get subtle => ZincColors.zincOliveGreen.shade100;
}

//Success Text/Icon
class SuccessTextIcon extends TextIcon {
  @override
  Color get label => ZincColors.zincOliveGreen.shade800;
}

//Warning Surface
class WarningSurface extends Surface {
  @override
  Color get darker => ZincColors.zincSelectiveYellow.shade700;

  @override
  Color get defaultC => ZincColors.zincSelectiveYellow.shade500;

  @override
  Color get lighter => ZincColors.zincSelectiveYellow.shade300;

  @override
  Color get subtle => ZincColors.zincSelectiveYellow.shade100;
}

//Warning Border
class WarningBorder extends _Border {
  @override
  Color get darker => ZincColors.zincSelectiveYellow.shade700;

  @override
  Color get defaultC => ZincColors.zincSelectiveYellow.shade500;

  @override
  Color get lighter => ZincColors.zincSelectiveYellow.shade300;

  @override
  Color get subtle => ZincColors.zincSelectiveYellow.shade100;
}

//warning Text/Icon
class WarningTextIcon extends TextIcon {
  @override
  Color get label => ZincColors.zincSelectiveYellow.shade800;
}

//Secondary Surface
class SecondarySurface extends Surface {
  @override
  Color get darker => ZincColors.zincChrome.shade700;

  @override
  Color get defaultC => ZincColors.zincChrome.shade500;

  @override
  Color get lighter => ZincColors.zincChrome.shade200;

  @override
  Color get subtle => ZincColors.zincChrome.shade50;
}

//Secondary Border
class SecondaryBorder extends _Border {
  @override
  Color get darker => ZincColors.zincChrome.shade700;

  @override
  Color get defaultC => ZincColors.zincChrome.shade500;

  @override
  Color get lighter => ZincColors.zincChrome.shade300;

  @override
  Color get subtle => ZincColors.zincChrome.shade100;
}

//Secondary Text/Icon
class SecondaryTextIcon extends TextIcon {
  @override
  Color get label => ZincColors.zincChrome.shade700;

  Color get highlight => ZincColors.zincChrome.shade600;
}

//Greyscale Surface
class GreyscaleSurface extends Surface {
  @override
  Color get darker => ZincColors.zincGrey.shade900;

  @override
  Color get defaultC => ZincColors.zincGrey.shade50;

  @override
  Color get lighter => ZincColors.zincGrey.shade200;

  @override
  Color get subtle => ZincColors.zincGrey.shade100;

  Color get disabled => ZincColors.zincGrey.shade300;

  Color get shimmer => ZincColors.zincGrey.shade300;

  Color get black => const Color(0xff1F1F1F);

  Color get white => const Color(0xffFFFFFF);
}

//Greyscale Border
class GreyscaleBorder extends _Border {
  @override
  Color get darker => ZincColors.zincGrey.shade700;

  @override
  Color get defaultC => ZincColors.zincGrey.shade400;

  @override
  Color get lighter => throw UnimplementedError();

  @override
  Color get subtle => ZincColors.zincGrey.shade100;

  Color get disbaled => ZincColors.zincGrey.shade300;

  Color get black => const Color(0xFF262626);

  Color get selected => ZincColors.zincGreen.shade600;
}

//Greyscale Text/Icon
class GreyscaleText extends TextIcon {
  @override
  Color get label => throw UnimplementedError();

  Color get title => const Color(0xFF262626);

  Color get textBlack => const Color(0xff262626);

  Color get body => ZincColors.zincGrey.shade900;

  Color get subtitle => ZincColors.zincGrey.shade800;

  Color get caption => ZincColors.zincGrey.shade700;

  Color get negative => ZincColors.zincGrey.shade50;

  Color get disabled => ZincColors.zincGrey.shade700;

  Color get white => const Color(0xffffffff);

  Color get placeholder => ZincColors.zincGrey.shade600;

  GreyscaleText();
}
