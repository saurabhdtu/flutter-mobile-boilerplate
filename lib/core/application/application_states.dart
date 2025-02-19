abstract class ApplicationState {}

class AppLoading extends ApplicationState {}

class UserLoggedOut extends ApplicationState {}

class HandleDeeplinkRoute extends ApplicationState {
  final String route;
  final Map<String,String>? args;

  HandleDeeplinkRoute(this.route, {this.args});
}

// class OnFileStatus
