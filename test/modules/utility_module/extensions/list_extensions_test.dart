
import 'package:flutter_test/flutter_test.dart';
import 'package:utility_module/extensions/list_extensions.dart'; // Replace with the actual file name

void main() {
  group('ListUtils', () {
    test('isEmptyOrNull returns true for null list', () {
      List? nullList;
      expect(nullList.isEmptyOrNull(), isTrue);
    });test('isEmptyOrNull returns true for empty list', () {
      final emptyList = <int>[];
      expect(emptyList.isEmptyOrNull(), isTrue);
    });

    test('isEmptyOrNull returns false for non-empty list', () {
      final nonEmptyList = [1, 2, 3];
      expect(nonEmptyList.isEmptyOrNull(), isFalse);
    });
  });
}