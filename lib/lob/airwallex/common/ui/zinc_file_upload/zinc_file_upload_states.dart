abstract class ZincFileUploadStates {}


class UploadStartedState extends ZincFileUploadStates {}


class UploadProgressState extends ZincFileUploadStates {
  double progress;
  String? message;
  bool isComplete;

  UploadProgressState(this.progress, this.isComplete, {this.message});
}