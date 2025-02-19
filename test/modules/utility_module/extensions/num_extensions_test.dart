
import 'package:flutter_test/flutter_test.dart';
import 'package:utility_module/extensions/num_extensions.dart'; // Replace with the actual file name
void main() {
  group('CurrencyFormat', () {
    test('formatToIntlCurrency formats number correctly', () {
      expect(1234567.89.formatToIntlCurrency(), '1,234,567.89');
    });

    test('formatToIntlCurrency handles without zeroes', () {
      expect(0.formatToIntlCurrency(), '0');
    });
    test('formatToIntlCurrency handles with zeroes', () {
      expect(0.formatToIntlCurrency(withZeroes: true), '0.00');
    });
    test('formatToIntlCurrency handles zero with decimal without zeroes', () {
      expect(0.5.formatToIntlCurrency(), '0.5');
    });
    test('formatToIntlCurrency handles zero with decimal with zeroes', () {
      expect(0.5.formatToIntlCurrency(withZeroes: true), '0.50');
    });
    test('formatToIndianCurrency formats number correctly', () {
      expect(123456789012.34.formatToIndianCurrency(), '1,23,45,67,89,012.34');
    });

    test('formatToIndianCurrency handles zero correctly', () {
      expect(0.formatToIndianCurrency(), '0.00');
    });
  });
}