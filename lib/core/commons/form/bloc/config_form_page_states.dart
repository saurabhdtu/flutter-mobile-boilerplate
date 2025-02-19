abstract class ConfigFormPageStates {}

class ConfigFormPageError extends ConfigFormPageStates {
  final String message;

  ConfigFormPageError(this.message);
}

class ConfigFormPageLoader extends ConfigFormPageStates {
  final bool showLoader;
  final String? message;

  ConfigFormPageLoader(this.showLoader, {this.message});
}

class ConfigFormPageLoading extends ConfigFormPageStates {
}

class ConfigFormPageLoaded extends ConfigFormPageStates {
}

class NavigateFromConfigFormPage extends ConfigFormPageStates {
  final String route;
  final Map<String, dynamic>? args;

  NavigateFromConfigFormPage(this.route, {this.args});
}