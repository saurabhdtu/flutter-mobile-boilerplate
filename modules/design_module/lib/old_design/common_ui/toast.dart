import 'package:design_module/resources/zinc_colors.dart';
import 'package:design_module/resources/zinc_style_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showZincToast(final String? message, {Toast toastLength = Toast.LENGTH_SHORT}) {
  if (message != null) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: toastLength,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ZincColors.black90,
        textColor: GreyscaleText().white,
        fontSize: 16.0);
  }
}
