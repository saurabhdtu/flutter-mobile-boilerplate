import 'package:go_router/go_router.dart';

extension CheckListRoutes on List<String> {
  bool isPathOf(String path) {
    bool isFound = false;
    for (var i = 0; i < this.length; i++) {
      if (isFound == false) {
        isFound = path.contains(this[i]);
      }
    }
    return isFound;
  }
}

extension GoRouterExtension on GoRouter {
  // Navigate back to a specific route
  void popUntilPath(String ancestorPath) {
    while (routerDelegate.currentConfiguration.matches.last.matchedLocation !=
        ancestorPath) {
      if (!canPop()) {
        return;
      }
      pop();
    }
  }

  void clearAllPathAndPush(String pathToPush) {
    while (canPop()) {
      pop();
    }
    pushNamed(pathToPush);
  }

  void pushNamedAndPopUntil(String popTargetPath, String pushNamedPath) {
    while (routerDelegate.currentConfiguration.matches.last.matchedLocation !=
        popTargetPath) {
      if (!canPop()) {
        return;
      }
      pop();
    }
    pushNamed(pushNamedPath);
  }

  void pushNamedAndPopUntilWithArgs(
      String popTargetPath, String pushNamedPath, Map<String, String> args) {
    while (routerDelegate.currentConfiguration.matches.last.matchedLocation !=
        popTargetPath) {
      if (!canPop()) {
        return;
      }
      pop();
    }
    pushNamed(pushNamedPath, pathParameters: args);
  }
}
