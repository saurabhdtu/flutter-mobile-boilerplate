import 'package:network_module/data/network/api/zinc_request_response.dart';

abstract class SplashState{}

class SplashLoading extends SplashState{}

class ModulesInitialized extends SplashState{}
class NavigateFromSplash extends SplashState{
  final String route;

  NavigateFromSplash(this.route);
}

class RootedDeviceDetected extends SplashState{
  bool isRooted;

  RootedDeviceDetected(this.isRooted);
}

class SplashError extends SplashState{
  ZincAPIError zincAPIError;
  SplashError(this.zincAPIError);
}
