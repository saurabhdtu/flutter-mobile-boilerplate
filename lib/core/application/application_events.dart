abstract class ApplicationEvent {}

class LogOutEvent extends ApplicationEvent {}

class DeeplinkOpened extends ApplicationEvent {
  final String route;

  DeeplinkOpened(this.route);
}

class NotificationClicked extends ApplicationEvent {
  final Map data;

  NotificationClicked(this.data);
}
