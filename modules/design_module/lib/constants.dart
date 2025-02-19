abstract class AssetPaths {
  static const imageAsset = "assets/images/";
  static const svgAsset = "assets/svg/";
  static const lottieAsset = "assets/lottie/";
}

abstract class BottomSheetActions {
  static const actionPositive = "bottomSheetActionPositive";
  static const actionNegative = "bottomSheetActionNegative";
}

enum IllustrationType {
  image,
  lottie,
  asset,
  localSvg,
  serverSvg,
  flutterIcon,
  video
}

enum BannerType { small, medium, large }

enum CardType { small, medium, large }

enum FilePickerLaunchMode {
  localStorage("Local storage"),
  cameraImageFront("Front camera"),
  cameraImageBack("Back camera"),
  unknown("Unknown");

  final String name;

  const FilePickerLaunchMode(this.name);
}

enum ClickAction { next, previous, route, formSubmit, none }

enum PageType {
  emailVerification,
  aadharVerification,
  form,
  passportVerification,
  none
}
