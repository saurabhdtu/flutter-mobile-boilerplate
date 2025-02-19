class LogMessage {
  int timeStamp;
  String message;

  LogMessage({required this.timeStamp, required this.message});

  Map<String, dynamic> toJson() {
    return {
      "timeStamp": this.timeStamp,
      "message": this.message,
    };
  }

  factory LogMessage.fromJson(Map<dynamic, dynamic> json) {
    return LogMessage(
      timeStamp:json["timeStamp"],
      message: json["message"],
    );
  }
//
}
