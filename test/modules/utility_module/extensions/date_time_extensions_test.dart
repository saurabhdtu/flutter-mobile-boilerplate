
import 'package:flutter_test/flutter_test.dart';
import 'package:utility_module/extensions/date_time_extensions.dart'; // Replace with the actual file name

void main() {
  group('DateTimeExtension', () {
    test('toTransactionTimeStamp - Today', () {
      final now = DateTime.now();
      final formatted = now.toTransactionTimeStamp();
      expect(formatted,startsWith("Today, "));
    });

    test('toTransactionTimeStamp - Yesterday', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      final formatted = yesterday.toTransactionTimeStamp();
      expect(formatted, startsWith("Yesterday, "));
    });

    test('toTransactionTimeStamp - Other Date', () {
      final date = DateTime(2024, 1, 1);
      final formatted = date.toTransactionTimeStamp();
      expect(formatted, "01 Jan 2024, 12:00 AM");
    });

    test('formatToCountdownString - Positive Duration', () {
      final futureDate = DateTime.now().add(const Duration(hours: 2, minutes: 30, seconds: 15));
      final formatted = futureDate.formatToCountdownString();
      expect(formatted, "02:30:14");
    });

    test('formatToCountdownString - Negative Duration', () {
      final pastDate = DateTime.now().subtract(const Duration(hours: 1));
      final formatted = pastDate.formatToCountdownString();
      expect(formatted, "");
    });

    test('formatToCountdownString - Without Hours', () {
      final futureDate = DateTime.now().add(const Duration(minutes: 30, seconds: 15));
      final formatted = futureDate.formatToCountdownString(showHours: false);
      expect(formatted, "30:14");
    });

    test('formatToDayTime', () {
      final date = DateTime(2024, 1, 1, 10);
      final formatted = date.formatToDayTime();
      expect(formatted, "Mon 10AM");
    });

    test('formatToDate', () {
      final date = DateTime(2024, 1, 1);
      final formatted = date.formatToDate();
      expect(formatted, "2024-01-01");
    });

    test('formatToTZFormat', () {
      final date = DateTime(2024, 1, 1, 10, 30);
      final formatted = date.formatToTZFormat();
      final expected = "2024-01-01T10:30:00.000"; // Adjust timezone as needed
      expect(formatted, contains(expected));
    });
  });

  group('DateTimeFormatting', () {
/*    test('formatToTransactionTimestamp - Valid Input', () {
      final formatted = DateTimeFormatting.getInstance.formatToTransactionTimestamp("2024-01-01T10:30:00.000Z");
      expect(formatted, "01 Jan 2024, 04:00 PM"); // Adjust timezone as needed
    });*/

    test('formatToTransactionTimestamp - Null Input', () {
      final formatted = DateTimeFormatting.getInstance.formatToTransactionTimestamp(null);
      expect(formatted, "");
    });

    test('formatToDateTime - Valid Input', () {
      final dateTime = DateTimeFormatting.getInstance.formatToDateTime("2024-01-01T10:30:00");
      expect(dateTime, isNotNull);
      expect(dateTime?.year, 2024);
      expect(dateTime?.month, 1);
      expect(dateTime?.day, 1);
      expect(dateTime?.hour, 10);
      expect(dateTime?.minute, 30);
    });

    test('formatToDateTime - Null Input', () {
      final dateTime = DateTimeFormatting.getInstance.formatToDateTime(null);
      expect(dateTime, isNull);
    });

 /*   test('formatToDateTimeWithTZ - Valid Input', () {
      final dateTime = DateTimeFormatting.getInstance.formatToDateTimeWithTZ("2024-01-01T10:30:00.000Z");
      expect(dateTime, isNotNull);
      expect(dateTime?.year, 2024);
      expect(dateTime?.month, 1);
      expect(dateTime?.day, 1);
      expect(dateTime?.hour, 16);
      expect(dateTime?.minute, 0);
    });*/

    test('formatToDateTimeWithTZ - Null Input', () {
      final dateTime = DateTimeFormatting.getInstance.formatToDateTimeWithTZ(null);
      expect(dateTime, isNull);
    });


    test('changeUiToServerDate - Success', () {
      final dateTime1 = DateTimeFormatting.getInstance.uiToServerDateFormat("12/10/2015");
      expect(dateTime1, "2015-10-12");
      final dateTime2 = DateTimeFormatting.getInstance.uiToServerDateFormat("01/01/1992");
      expect(dateTime2, "1992-01-01");
    });
  });
}