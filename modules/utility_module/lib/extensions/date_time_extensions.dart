import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toTransactionTimeStamp() {
    String time = _timeFormat.format(this);
    DateTime today = DateTime.timestamp();
    today = today.copyWith(hour: 0, minute: 0, second: 0, millisecond: 0);
    if (isAfter(today) || isAtSameMomentAs(today)) {
      return "Today, $time";
    }
    final yesterday = today.subtract(const Duration(days: 1));
    if (isAfter(yesterday) || isAtSameMomentAs(yesterday)) {
      return "Yesterday, $time";
    }
    return "${_dateFormat.format(this)}, $time";
  }

  String formatToCountdownString({bool showHours = true}) {
    final duration = difference(DateTime.now());
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    if (duration.isNegative) return "";
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "${showHours ? hours + ":" : ""}$minutes:$seconds";
  }

  String formatToDayTime() {
    return _dayTime.format(this);
  }

  String formatToDate() => _serverDateFormat.format(this);

  String formatToTZFormat() => this.toIso8601String();
}

DateFormat _tZFormatWithoutZone = DateFormat("yyyy-MM-ddTHH:mm:ss");
DateFormat _timeFormat = DateFormat("hh:mm a");
DateFormat _dateFormat = DateFormat("dd MMM yyyy");
DateFormat _dayTime = DateFormat("EEE hha");
DateFormat _serverDateFormat = DateFormat("yyyy-MM-dd");
DateFormat _uiDateFormat = DateFormat("dd/MM/yyyy");
DateFormat _hvDateFormat = DateFormat("yyyyMMdd000000000");

class DateTimeFormatting {
  static DateTimeFormatting? _instance;

  DateTimeFormatting._();

  static DateTimeFormatting get getInstance =>
      _instance ??= DateTimeFormatting._();

  String formatToTransactionTimestamp(final String? time) {
    if (time == null) return "";
    DateTime dateTime = DateTime.parse(time).toLocal();
    return dateTime.toTransactionTimeStamp();
  }

  DateTime? formatToDateTime(final String? time) {
    if (time == null) return null;
    return _tZFormatWithoutZone.parse(time).toLocal();
  }

  DateTime? formatToDateTimeWithTZ(final String? time) {
    if (time == null) return null;
    return DateTime.parse(time).toLocal(); //_tZFormat.parse(time).toLocal();
  }

  String formatDateToHVDateString(final DateTime time) {
    return _hvDateFormat.format(time);
  }

  String uiToServerDateFormat(String date) =>
      _serverDateFormat.format(_uiDateFormat.parse(date));
}
