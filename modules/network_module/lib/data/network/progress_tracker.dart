

class RequestProgressTracker {
  final Function(int, int)? sendProgress;
  final Function(int, int)? receiveProgress;

  RequestProgressTracker({this.sendProgress, this.receiveProgress});
}
