
import 'package:flutter_test/flutter_test.dart';
import 'package:utility_module/extensions/map_extensions.dart'; // Replace with the actual file name

void main() {
  group('MapExtensions', () {
    test('hasKeyThatContains returns true for matching key',() {
      final map = {'apple': 1, 'banana': 2, 'orange': 3};
      expect(map.hasKeyThatContains('apple'), isTrue);
    });

    test('hasKeyThatContains returns true for partial match', () {
      final map = {'apple': 1, 'banana': 2, 'orange': 3};
      expect(map.hasKeyThatContains('app'), isTrue);
    });

    test('hasKeyThatContains returns false for no match', () {
      final map = {'apple': 1, 'banana': 2, 'orange': 3};
      expect(map.hasKeyThatContains('grape'), isFalse);
    });

    test('hasKeyThatContains returns false for empty map', () {
      final map = <String, dynamic>{};
      expect(map.hasKeyThatContains('apple'), isFalse);
    });
  });
}